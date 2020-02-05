import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';

import 'package:crocodile_game/app/service/services.dart';
import 'package:crocodile_game/app/ui/team_play/module.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/model/enum/enums.dart';

class TeamPlayViewModel implements TeamPlayViewModelType {

  final Injector _injector;
  GeneratorServiceType _generatorService;
  RemoteAnalyticsServiceType _remoteAnalyticsService;

  final _modeController = BehaviorSubject<TeamPlayMode>();
  final _itemController = BehaviorSubject<String>();
  final _teamController = BehaviorSubject<TeamItem>();

  List<CategoryInfoItem> _selectedCategories = [];
  List<TeamItem> _teams = [];
  bool _isTimerEnabled = false;
  int _timerSeconds = 0;

  TeamPlayMode _mode = TeamPlayMode.start;

  TeamPlayViewModel(this._injector, TeamPlayModeBuilder params) {
    _generatorService = _injector.getDependency<GeneratorServiceType>();
    _remoteAnalyticsService = _injector.getDependency<RemoteAnalyticsServiceType>();

    _selectedCategories = params.categories;
    _teams = params.teams;
    _isTimerEnabled = params.isTimerTurnedOn;
    _timerSeconds = params.timerSeconds;
  }

  @override
  Stream<String> get item => _itemController.stream;

  @override
  Stream<TeamPlayMode> get mode => _modeController.stream;

  @override
  Stream<TeamItem> get currentTeam => _teamController.stream;

  @override
  void initState(BuildContext context) async {
    _remoteAnalyticsService.setCurrentScreen('team_play');
    await _generatorService.start(context, _selectedCategories);

    // set current play mode as starting one
    _modeController.sink.add(_mode);

    _pickRandomTeam();
  }

  @override
  void startGameAction(BuildContext context) {
    _generateNewWord(context);

    _modeController.sink.add(TeamPlayMode.act);
  }

  @override
  void wordGuessedAction(BuildContext context) async {
    _generateNewWord(context);

    _modeController.sink.add(TeamPlayMode.nextTeam);
  }

  @override
  void wordNotGuessedAction(BuildContext context) {
    _generateNewWord(context);
    
    _modeController.sink.add(TeamPlayMode.nextTeam);
  }

  @override
  void endGameAction(BuildContext context) {
    _modeController.sink.add(TeamPlayMode.results);
  }

  @override
  void nextTeamPlayAction(BuildContext context) {
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
  void dispose() {
    _itemController.close();
    _modeController.close();
    _teamController.close();
  }

  void _generateNewWord(BuildContext context) async {
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "user_action", parameters: { 'type': 'generate_new_word' });
    _remoteAnalyticsService.sendAnalyticsEvent(event);
    String word = await _generatorService.getRandomWord(context);
    _itemController.sink.add(word);
  }

  void _pickRandomTeam() {
    _teamController.sink.add(_teams.first);
  }

}
