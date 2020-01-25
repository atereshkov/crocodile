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

  final List<CategoryInfoItem> _selectedCategories;

  final _itemsController = BehaviorSubject<List<TeamItem>>();
  final _startButtonEnabledController = BehaviorSubject<bool>();
  final _timerCheckboxController = BehaviorSubject<bool>();
  final _timerDropdownController = BehaviorSubject<String>();

  SelectTeamViewModel(this._injector, this._selectedCategories) {
    _remoteAnalyticsService = _injector.getDependency<RemoteAnalyticsServiceType>();
  }

  @override
  Stream<List<TeamItem>> get getTeamsStream => _itemsController.stream;

  @override
  Stream<bool> get startGameButtonEnabledStream => _startButtonEnabledController.stream;

  @override
  Stream<bool> get isTimerChecked => _timerCheckboxController.stream;

  @override
  Stream<String> get timerValue => _timerDropdownController.stream;
  
  @override
  void initState(BuildContext context) async {
    List<TeamItem> teams = [];

    teams.add(TeamItem(name: 'Team 1', id: Random().nextInt(1000000).toString()));
    teams.add(TeamItem(name: 'Team 2', id: Random().nextInt(1000000).toString()));

    _itemsController.sink.add(teams);

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
    print('Delete');
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
  void startGameAction(BuildContext context) {
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "open_screen", parameters: { 'screen': 'team_play', 'from': 'select_team' });
    _remoteAnalyticsService.sendAnalyticsEvent(event);
    TeamPlayViewModelType vm = TeamPlayViewModel(_injector, _selectedCategories);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeamPlayPage(vm)));
  }

  @override
  void dispose() {
    _itemsController.close();
    _startButtonEnabledController.close();
    _timerCheckboxController.close();
    _timerDropdownController.close();
  }

}
