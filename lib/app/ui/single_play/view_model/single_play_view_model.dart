import 'package:crocodile_game/app/service/services.dart';
import 'package:crocodile_game/app/ui/single_play/view_model/single_play_view_model_type.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';

class SinglePlayViewModel implements SinglePlayViewModelType {
  final Injector _injector;
  GeneratorServiceType _generatorService;

  final _itemController = BehaviorSubject<String>();

  SinglePlayViewModel(this._injector) {
    _generatorService = _injector.getDependency<GeneratorServiceType>();
  }

  Stream<String> get item => _itemController.stream;

  @override
  void initState(BuildContext context) async {
    _generatorService.start(context);
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
    String word = await _generatorService.getRandomWord(context);
    _itemController.sink.add(word);
  }

}
