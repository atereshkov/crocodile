import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';

import 'package:crocodile_game/app/service/services.dart';
import 'package:crocodile_game/app/ui/single_play/module.dart';
import 'package:crocodile_game/app/ui/select_category/module.dart';
import 'package:crocodile_game/app/model/models.dart';

class SinglePlayViewModel implements SinglePlayViewModelType {

  final Injector _injector;
  GeneratorServiceType _generatorService;
  RemoteAnalyticsServiceType _remoteAnalyticsService;

  final _itemController = BehaviorSubject<String>();

  List<CategoryItem> selectedCategories = [];

  SinglePlayViewModel(this._injector) {
    _generatorService = _injector.getDependency<GeneratorServiceType>();
    _remoteAnalyticsService = _injector.getDependency<RemoteAnalyticsServiceType>();
  }

  Stream<String> get item => _itemController.stream;

  @override
  void initState(BuildContext context) async {
    _remoteAnalyticsService.setCurrentScreen('single_play');
    _generatorService.start(context);
  }

  @override
  void generateNewWordAction(BuildContext context) {
    _generateNewWord(context);
  }

  @override
  void selectCategoryAction(BuildContext context) {
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "open_screen", parameters: { 'screen': 'select_category', 'from': 'single_play' });
    _remoteAnalyticsService.sendAnalyticsEvent(event);
    SelectCategoryViewModelType vm = SelectCategoryViewModel(_injector, selectedCategories);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectCategoryPage(vm)));
  }

  @override
  void dispose() {
    _itemController.close();
  }

  void _generateNewWord(BuildContext context) async {
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "user_action", parameters: { 'type': 'generate_new_word' });
    _remoteAnalyticsService.sendAnalyticsEvent(event);
    String word = await _generatorService.getRandomWord(context);
    _itemController.sink.add(word);
  }

}
