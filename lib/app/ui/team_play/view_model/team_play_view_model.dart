import 'package:crocodile_game/app/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:crocodile_game/app/service/services.dart';
import 'package:crocodile_game/app/ui/team_play/module.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/model/enum/enums.dart';

class TeamPlayViewModel implements TeamPlayViewModelType {

  final Injector _injector;
  GeneratorServiceType _generatorService;
  TeamPlayServiceType _teamPlayService;
  RemoteAnalyticsServiceType _remoteAnalyticsService;

  final _modeController = BehaviorSubject<TeamPlayMode>();
  final _itemController = BehaviorSubject<String>();
  final _teamController = BehaviorSubject<TeamItem>();
  final _roundsLeftController = BehaviorSubject<int>();
  final _timerSecondsLeftController = BehaviorSubject<int>();
  final _snackBarMessageController = BehaviorSubject<SnackbarMessage>();

  List<CategoryInfoItem> _selectedCategories = [];
  List<TeamItem> _teams = [];
  TeamPlayModeBuilder gameParameters;

  Timer _timer;
  TeamPlayMode _mode = TeamPlayMode.start;

  TeamPlayViewModel(this._injector, TeamPlayModeBuilder params) {
    _generatorService = _injector.getDependency<GeneratorServiceType>();
    _teamPlayService = _injector.getDependency<TeamPlayServiceType>();
    _remoteAnalyticsService = _injector.getDependency<RemoteAnalyticsServiceType>();

    _selectedCategories = params.categories;
    _teams = params.teams;
    gameParameters = params;
  }

  @override
  Stream<String> get item => _itemController.stream;

  @override
  Stream<TeamPlayMode> get mode => _modeController.stream;

  @override
  Stream<TeamItem> get currentTeam => _teamController.stream;

  @override
  Stream<int> get roundsLeft => _roundsLeftController.stream;

  @override
  Stream<int> get timerSecondsLeft => _timerSecondsLeftController.stream;

  @override
  int get fullTimerValue => gameParameters.timerSeconds;

  @override
  Stream<SnackbarMessage> get onSnackBarMessage => _snackBarMessageController.stream;

  @override
  void initState(BuildContext context) async {
    _remoteAnalyticsService.setCurrentScreen('team_play');
    await _generatorService.start(context, _selectedCategories);
    await _teamPlayService.start(context, gameParameters);

    // set current play mode as starting one
    _modeController.sink.add(_mode);

    _pickRandomTeam();

    if (gameParameters.isTimerTurnedOn) {
      _timerSecondsLeftController.sink.add(gameParameters.timerSeconds);
    }
  }

  @override
  void startGameAction(BuildContext context) {
    _generateNewWord(context);

    if (gameParameters.isTimerTurnedOn) {
      _timerSecondsLeftController.sink.add(gameParameters.timerSeconds);
      _runTimer(context);
    }

    _modeController.sink.add(TeamPlayMode.act);
  }

  @override
  void wordGuessedAction(BuildContext context) async {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }

    String teamName = _teamController.value.name;
    String wordGuessed = AppLocalizations.of(context).teamPlayGameSnackbarWordNotGuessed;
    String addPoints = AppLocalizations.of(context).teamPlayGameMinusPoints;
    SnackbarMessage message = SnackbarMessage(text: '$wordGuessed $teamName $addPoints!', color: Colors.green);
    _snackBarMessageController.sink.add(message);

    _generateNewWord(context);
    _teamPlayService.wordIsGuessed();
    _pickRandomTeam();

    if (_teamPlayService.gameIsActive()) {
      _modeController.sink.add(TeamPlayMode.nextTeam);
    } else {
      // if no rounds left, open results screen
      _modeController.sink.add(TeamPlayMode.results);
    }
  }

  @override
  void wordNotGuessedAction(BuildContext context) {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }

    String teamName = _teamController.value.name;
    String wordNotGuessed = AppLocalizations.of(context).teamPlayGameSnackbarWordNotGuessed;
    String minusPoints = AppLocalizations.of(context).teamPlayGameMinusPoints;
    SnackbarMessage message = SnackbarMessage(text: '$wordNotGuessed $teamName $minusPoints!', color: Colors.red);
    _snackBarMessageController.sink.add(message);

    _generateNewWord(context);
    _teamPlayService.wordIsNotGuessed();
    _pickRandomTeam();
    
    if (_teamPlayService.gameIsActive()) {
      _modeController.sink.add(TeamPlayMode.nextTeam);
    } else {
      // if no rounds left, open results screen
      _modeController.sink.add(TeamPlayMode.results);
    }
  }

  @override
  void endGameAction(BuildContext context) {
    _modeController.sink.add(TeamPlayMode.results);
  }

  @override
  void nextTeamPlayAction(BuildContext context) {
    if (gameParameters.isTimerTurnedOn) {
      _timerSecondsLeftController.sink.add(gameParameters.timerSeconds);
      if (_timer.isActive) {
        _timer.cancel();
      }
      _runTimer(context);
    }

    _modeController.sink.add(TeamPlayMode.act);
  }

  @override
  void shareResultsAction(BuildContext context) {
    
  }

  @override
  void playAgainAction(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  List<TeamPoints> getWinners() {
    Map<String, int> teamPoints = _teamPlayService.teamPoints;
    List<TeamPoints> winners = List<TeamPoints>();
    
    for (var pointsMap in teamPoints.entries) {
      TeamItem team = _teams.firstWhere((t) => t.id == pointsMap.key, orElse: () => null);
      TeamPoints teamPoints = TeamPoints(team: team, points: pointsMap.value);
      winners.add(teamPoints);
    }

    winners.sort((a, b) => b.points.compareTo(a.points));

    return winners;
  }

  @override
  void dispose() {
    _itemController.close();
    _modeController.close();
    _teamController.close();
    _roundsLeftController.close();
    _timerSecondsLeftController.close();
    _snackBarMessageController.close();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void _generateNewWord(BuildContext context) async {
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "user_action", parameters: { 'type': 'generate_new_word' });
    _remoteAnalyticsService.sendAnalyticsEvent(event);
    String word = await _generatorService.getRandomWord(context);
    _itemController.sink.add(word);
  }

  void _pickRandomTeam() async {
    TeamItem team = await _teamPlayService.getRandomTeam();
    _teamController.sink.add(team);
  }
  
  void _runTimer(BuildContext context) {
    int countdown = gameParameters.timerSeconds;

      const timerTick = const Duration(seconds: 1);
      _timer = Timer.periodic(
        timerTick, (Timer timer) {
          if (countdown < 1) {
            // time is left
            wordNotGuessedAction(context);
            timer.cancel();
          } else {
            countdown = countdown - 1;
            _timerSecondsLeftController.sink.add(countdown);
          }
        },
      );
  }

}
