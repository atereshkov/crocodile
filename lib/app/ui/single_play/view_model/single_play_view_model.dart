import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';

import 'package:crocodile_game/app/service/services.dart';
import 'package:crocodile_game/app/ui/single_play/module.dart';
import 'package:crocodile_game/app/model/models.dart';

class SinglePlayViewModel implements SinglePlayViewModelType {

  final Injector _injector;
  GeneratorServiceType _generatorService;
  RemoteAnalyticsServiceType _remoteAnalyticsService;

  final _itemController = BehaviorSubject<String>();

  List<CategoryInfoItem> _selectedCategories = [];

  SinglePlayViewModel(this._injector, this._selectedCategories) {
    _generatorService = _injector.getDependency<GeneratorServiceType>();
    _remoteAnalyticsService = _injector.getDependency<RemoteAnalyticsServiceType>();
  }

  Stream<String> get item => _itemController.stream;

  @override
  void initState(BuildContext context) async {
    _remoteAnalyticsService.setCurrentScreen('single_play');
    await _generatorService.start(context, _selectedCategories);
    _generateNewWord(context);
  }

  @override
  void generateNewWordAction(BuildContext context) {
    _generateNewWord(context);
  }

  @override
  void dispose() {
    _itemController.close();
  }

  void _generateNewWord(BuildContext context) async {
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "user_action", parameters: { 'type': 'generate_new_word_single' });
    _remoteAnalyticsService.sendAnalyticsEvent(event);
    String word = await _generatorService.getRandomWord(context);
    _itemController.sink.add(word);
  }

}
