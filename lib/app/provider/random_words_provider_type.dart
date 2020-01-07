import 'package:crocodile_game/app/model/models.dart';

abstract class RandomWordsProviderType {
  Future<List<WordItem>> getAllWords(String jsonData);
  Future<List<WordItem>> getWordsByCategories(List<CategoryItem> categories);
}
