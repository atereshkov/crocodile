import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:crocodile_game/app/ui/select_team/module.dart';
import 'package:crocodile_game/app/ui/team_play/module.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/service/services.dart';
import 'package:crocodile_game/app/ui/dialog/text_dialog.dart';

import 'dart:math';

class SelectTeamViewModel implements SelectTeamViewModelType {

  final Injector _injector;

  RemoteAnalyticsServiceType _remoteAnalyticsService;
  TeamGeneratorServiceType _teamGeneratorService;

  final List<CategoryInfoItem> _selectedCategories;

  final _teamsController = BehaviorSubject<List<TeamItem>>();
  final _startButtonEnabledController = BehaviorSubject<bool>();
  final _timerCheckboxController = BehaviorSubject<bool>();
  final _roundsCheckboxController = BehaviorSubject<bool>();
  final _timerDropdownController = BehaviorSubject<String>();
  final _roundsDropdownController = BehaviorSubject<String>();

  SelectTeamViewModel(this._injector, this._selectedCategories) {
    _remoteAnalyticsService = _injector.getDependency<RemoteAnalyticsServiceType>();
    _teamGeneratorService = _injector.getDependency<TeamGeneratorServiceType>();
  }

  @override
  Stream<List<TeamItem>> get getTeamsStream => _teamsController.stream;

  @override
  Stream<bool> get startGameButtonEnabledStream => _startButtonEnabledController.stream;

  @override
  Stream<bool> get isTimerChecked => _timerCheckboxController.stream;

  @override
  Stream<bool> get isRoundsChecked => _roundsCheckboxController.stream;

  @override
  Stream<String> get timerValue => _timerDropdownController.stream;

  @override
  Stream<String> get roundsValue => _roundsDropdownController.stream;
  
  @override
  void initState(BuildContext context) async {
    await _teamGeneratorService.start(context);

    await _addStubTeams(context);

    // enable timer checkbox by default
    _timerCheckboxController.sink.add(true);

    // enable rounds checkbox by default
    _roundsCheckboxController.sink.add(true);

    // disable play button by default
    _startButtonEnabledController.sink.add(true);

    _timerDropdownController.sink.add('60');
    _roundsDropdownController.sink.add('5');
  }

  @override
  void handleTeamItemTap(BuildContext context, TeamItem item) async {
    TextDialogPresenterType dialogPresenter = TextDialogPresenter(
      'Change name',
      item.name,
      (newTeamName) async {
        List<TeamItem> currentTeams = _teamsController.value;

        // avoid changing team name to already existing one
        final duplicatedTeam = currentTeams.firstWhere((i) => i.name == newTeamName, orElse: () => null);
        if (duplicatedTeam != null) {
          return;
        }

        int prevIndex = currentTeams.indexOf(item);
        currentTeams.remove(item);

        item.rename(newTeamName);
        currentTeams.insert(prevIndex, item);

        _teamsController.sink.add(currentTeams);
      },
    );
    dialogPresenter.show(context);
  }

  @override
  void onTeamDeleteTap(TeamItem item) async {
    List<TeamItem> currentTeams = _teamsController.value;

    var teamToDelete = currentTeams.firstWhere((team) => team.id == item.id, orElse: () => null);
    currentTeams.remove(teamToDelete);

    _teamsController.sink.add(currentTeams);

    _updateStartGameButtonState();
  }

  @override
  void onTeamRenameTap(BuildContext context, TeamItem item) async {
    List<TeamItem> currentTeams = _teamsController.value;

    var teamToRename = currentTeams.firstWhere((team) => team.id == item.id, orElse: () => null);
    int prevIndex = currentTeams.indexOf(teamToRename);
    currentTeams.remove(teamToRename);

    List<String> currentTeamNames = currentTeams.map((t) => t.name).toList();
    String randomTeamName = await _teamGeneratorService.getRandomTeamName(context, currentTeamNames);
    teamToRename.rename(randomTeamName);
    currentTeams.insert(prevIndex, teamToRename);

    _teamsController.sink.add(currentTeams);

    _updateStartGameButtonState();
  }

  @override
  void onTimerCheckboxAction(bool value) {
    _timerCheckboxController.sink.add(value);
  }

  @override
  void timerDropdownAction(String value) {
    _timerDropdownController.sink.add(value);
  }

  @override
  void onRoundsCheckboxAction(bool value) {
    _roundsCheckboxController.sink.add(value);
  }

  @override
  void roundsDropdownAction(String value) {
    _roundsDropdownController.sink.add(value);
  }

  @override
  void addTeamAction(BuildContext context) async {
    List<TeamItem> currentTeams = _teamsController.value;

    List<String> currentTeamNames = currentTeams.map((t) => t.name).toList();
    String randomTeamName = await _teamGeneratorService.getRandomTeamName(context, currentTeamNames);

    TeamItem newTeam = TeamItem(id: Random().nextInt(1000000).toString(), name: randomTeamName);
    currentTeams.add(newTeam);
    _teamsController.sink.add(currentTeams);

    _updateStartGameButtonState();
  }

  @override
  void startGameAction(BuildContext context) {
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "open_screen", parameters: { 'screen': 'team_play', 'from': 'select_team' });
    _remoteAnalyticsService.sendAnalyticsEvent(event);

    TeamPlayModeBuilder params = TeamPlayModeBuilder();
    params.categories = _selectedCategories;
    params.teams = _teamsController.value;
    params.isTimerTurnedOn = _timerCheckboxController.value;
    params.timerSeconds = int.tryParse(_timerDropdownController.value) ?? 0;

    TeamPlayViewModelType vm = TeamPlayViewModel(_injector, params);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeamPlayPage(vm)));
  }

  void _updateStartGameButtonState() {
    bool isEnabled = _teamsController.value.isNotEmpty;
    _startButtonEnabledController.sink.add(isEnabled);
  }

  Future<void> _addStubTeams(BuildContext context) async {
    List<TeamItem> teams = [];

    String team1Name = await _teamGeneratorService.getRandomTeamName(context, []);
    TeamItem team1 = TeamItem(name: team1Name, id: Random().nextInt(1000000).toString());
    teams.add(team1);

    String team2Name = await _teamGeneratorService.getRandomTeamName(context, teams.map((t) => t.name).toList());
    TeamItem team2 = TeamItem(name: team2Name, id: Random().nextInt(1000000).toString());
    teams.add(team2);

    _teamsController.sink.add(teams);
  }

  @override
  void dispose() {
    _teamsController.close();
    _startButtonEnabledController.close();
    _timerCheckboxController.close();
    _roundsCheckboxController.close();
    _timerDropdownController.close();
    _roundsDropdownController.close();
  }

}
