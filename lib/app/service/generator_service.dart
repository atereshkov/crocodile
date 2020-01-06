import 'package:crocodile_game/app/model/word_item.dart';
import 'package:crocodile_game/app/service/services.dart';
import 'package:crocodile_game/app/provider/providers.dart';
import 'package:crocodile_game/app/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GeneratorService implements GeneratorServiceType {

  RandomWordsProviderType _wordsProvider;

  List<WordItem> _seenWords = List<WordItem>();
  List<WordItem> _allWords = List<WordItem>();

  GeneratorService(this._wordsProvider);

  @override
  void start(BuildContext context) async {
    _allWords = await _loadWords(context);
    _seenWords.clear();
  }

  @override
  Future<String> getRandomWord(BuildContext context) async {
    if (_allWords.length == 0) {
      _allWords = await _loadWords(context);
      _seenWords.clear();
    }

    final _random = new Random();
    final randomItem = _allWords[_random.nextInt(_allWords.length)];

    _seenWords.add(randomItem);
    _allWords.remove(randomItem);

    String word = randomItem.word;
    return Future.value(word);
  }

  Future<List<WordItem>> _loadWords(BuildContext context) async {
    // TODO: move to words provider
    String lang = AppLocalizations.of(context).getCurrentLangCode;
    String jsonFileName = "words";
    String resourceFile = 'resources/${jsonFileName}_$lang.json';
    String json = await DefaultAssetBundle.of(context).loadString(resourceFile);
    return _wordsProvider.getAllWords(json);
  }

}
