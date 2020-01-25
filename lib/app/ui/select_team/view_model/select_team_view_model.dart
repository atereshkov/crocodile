import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:crocodile_game/app/ui/select_team/module.dart';
import 'package:crocodile_game/app/ui/team_play/module.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/service/services.dart';

class SelectTeamViewModel implements SelectTeamViewModelType {

  final Injector _injector;

  RemoteAnalyticsServiceType _remoteAnalyticsService;

  final List<CategoryInfoItem> _selectedCategories;

  final _itemsController = BehaviorSubject<List<TeamItem>>();
  final _startButtonEnabledController = BehaviorSubject<bool>();

  SelectTeamViewModel(this._injector, this._selectedCategories) {
    _remoteAnalyticsService = _injector.getDependency<RemoteAnalyticsServiceType>();
  }

  @override
  Stream<List<TeamItem>> get getTeamsStream => _itemsController.stream;

  @override
  Stream<bool> get startGameButtonEnabledStream => _startButtonEnabledController.stream;

  @override
  void initState(BuildContext context) async {
    
  }

  @override
  void handleTeamItemTap(TeamItem item) async {
    
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
  }

}
