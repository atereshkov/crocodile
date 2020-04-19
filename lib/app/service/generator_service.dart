import 'package:flutter/material.dart';
import 'dart:math';
import 'package:crocodile_game/app/model/word_item.dart';
import 'package:crocodile_game/app/service/services.dart';
import 'package:crocodile_game/app/provider/providers.dart';
import 'package:crocodile_game/app/model/models.dart';

class GeneratorService implements GeneratorServiceType {

  RandomWordsProviderType _wordsProvider;

  List<WordItem> _seenWords = List<WordItem>();
  List<WordItem> _allWords = List<WordItem>();
  List<CategoryInfoItem> _categories = List<CategoryInfoItem>();

  GeneratorService(this._wordsProvider);

  @override
  Future<void> preLoad(BuildContext context) async {
    _allWords = await _wordsProvider.getAllWords(context);
  }

  @override
  Future<void> start(BuildContext context, List<CategoryInfoItem> categories) async {
    _categories = categories;
    _allWords = await _loadWords(context);

    // remove already seen words from the new words
    for (var seenWord in _seenWords) {
      _allWords.removeWhere((w) => w.word == seenWord.word);
    }
  }

  @override
  Future<String> getRandomWord(BuildContext context) async {
    if (_allWords.length == 0) {
      _allWords = await _loadWords(context);

      // remove loaded new words from the seen words as there are no words left for play
      for (var newWord in _allWords) {
        _seenWords.removeWhere((w) => w.word == newWord.word);
      }
    }

    final randomItem = _allWords[Random().nextInt(_allWords.length)];

    _seenWords.add(randomItem);
    _allWords.remove(randomItem);

    String word = randomItem.word;
    return Future.value(word);
  }

  Future<List<WordItem>> _loadWords(BuildContext context) async {
    return _wordsProvider.getWordsByCategories(_categories, context);
  }

}
