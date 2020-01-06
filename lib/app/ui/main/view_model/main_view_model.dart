import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import 'package:crocodile_game/app/ui/main/view_model/main_view_model_type.dart';
import 'package:crocodile_game/app/ui/single_play/module.dart';
import 'package:crocodile_game/app/ui/rules/module.dart';
import 'package:crocodile_game/app/service/services.dart';
import 'package:crocodile_game/app/model/models.dart';

class MainViewModel implements MainViewModelType {
  Injector _injector;
  RemoteAnalyticsServiceType _remoteAnalyticsService;

  MainViewModel(this._injector) {
    _remoteAnalyticsService = _injector.getDependency<RemoteAnalyticsServiceType>();
  }

  @override
  void initState() {
    
  }

  @override
  void dispose() {
    
  }

  @override
  void singlePlayAction(BuildContext context) {
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "open_screen", parameters: { 'screen': 'single_play', 'from': 'main' });
    _remoteAnalyticsService.sendAnalyticsEvent(event);
    SinglePlayViewModelType vm = SinglePlayViewModel(_injector);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SinglePlayPage(vm)));
  }

  @override
  void howToPlayAction(BuildContext context) {
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "open_screen", parameters: { 'screen': 'rules', 'from': 'main' });
    _remoteAnalyticsService.sendAnalyticsEvent(event);
    RulesViewModelType vm = RulesViewModel(_injector);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RulesPage(vm)));
  }

}
