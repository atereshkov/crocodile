import 'package:crocodile_game/app/model/word_item.dart';

abstract class RandomWordsProviderType {
  Future<List<WordItem>> getAllWords();
  Future<List<WordItem>> getWordsByCategories();
}
