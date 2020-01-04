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
  Future<String> getRandomWord(BuildContext context) async {
    String lang = AppLocalizations.of(context).getCurrentLangCode;
    String jsonFileName = "words";
    String resourceFile = 'resources/${jsonFileName}_$lang.json';
    String json = await DefaultAssetBundle.of(context).loadString(resourceFile);

    if (_allWords.length == 0) {
      _allWords = await _wordsProvider.getAllWords(json);
    }

    final _random = new Random();
    final randomItem = _allWords[_random.nextInt(_allWords.length)];
    var word = randomItem.word;

    _seenWords.add(randomItem);
    _allWords.remove(randomItem);

    return Future.value(word);
  }

}
