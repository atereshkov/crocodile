import 'package:crocodile_game/app/model/word_item.dart';
import 'package:crocodile_game/app/model/category_item.dart';

abstract class RandomWordsProviderType {
  Future<List<WordItem>> getAllWords(String jsonData);
  Future<List<WordItem>> getWordsByCategories(List<CategoryItem> categories);
}
