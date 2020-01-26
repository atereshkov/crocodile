import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:crocodile_game/app/ui/select_team/module.dart';
import 'package:crocodile_game/app/ui/team_play/module.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/service/services.dart';

import 'dart:math';

class SelectTeamViewModel implements SelectTeamViewModelType {

  final Injector _injector;

  RemoteAnalyticsServiceType _remoteAnalyticsService;
  TeamGeneratorServiceType _teamGeneratorService;

  final List<CategoryInfoItem> _selectedCategories;

  final _teamsController = BehaviorSubject<List<TeamItem>>();
  final _startButtonEnabledController = BehaviorSubject<bool>();
  final _timerCheckboxController = BehaviorSubject<bool>();
  final _timerDropdownController = BehaviorSubject<String>();

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
  Stream<String> get timerValue => _timerDropdownController.stream;
  
  @override
  void initState(BuildContext context) async {
    await _teamGeneratorService.start(context);

    List<TeamItem> teams = [];

    teams.add(TeamItem(name: 'Team 1', id: Random().nextInt(1000000).toString()));
    teams.add(TeamItem(name: 'Team 2', id: Random().nextInt(1000000).toString()));

    _teamsController.sink.add(teams);

    // enable timer checkbox by default
    _timerCheckboxController.sink.add(true);

    // disable play button by default
    _startButtonEnabledController.sink.add(true);

    _timerDropdownController.sink.add('60');
  }

  @override
  void handleTeamItemTap(TeamItem item) async {
    print('Item');
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

  @override
  void dispose() {
    _teamsController.close();
    _startButtonEnabledController.close();
    _timerCheckboxController.close();
    _timerDropdownController.close();
  }

}
