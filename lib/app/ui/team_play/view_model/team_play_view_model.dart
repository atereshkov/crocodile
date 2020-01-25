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

  List<CategoryInfoItem> _selectedCategories = [];
  TeamPlayMode _mode = TeamPlayMode.prepare;

  TeamPlayViewModel(this._injector, this._selectedCategories) {
    _generatorService = _injector.getDependency<GeneratorServiceType>();
    _remoteAnalyticsService = _injector.getDependency<RemoteAnalyticsServiceType>();
  }

  @override
  Stream<String> get item => _itemController.stream;

  @override
  Stream<TeamPlayMode> get mode => _modeController.stream;

  @override
  void initState(BuildContext context) async {
    _remoteAnalyticsService.setCurrentScreen('team_play');
    await _generatorService.start(context, _selectedCategories);
    _generateNewWord(context);

    // set current mode as default
    _modeController.sink.add(_mode);
  }

  @override
  void generateNewWordAction(BuildContext context) {
    _generateNewWord(context);
  }

  @override
  void dispose() {
    _itemController.close();
    _modeController.close();
  }

  void _generateNewWord(BuildContext context) async {
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "user_action", parameters: { 'type': 'generate_new_word' });
    _remoteAnalyticsService.sendAnalyticsEvent(event);
    String word = await _generatorService.getRandomWord(context);
    _itemController.sink.add(word);
  }

}
