import 'dart:convert';
import 'package:crocodile_game/app/provider/random_words_provider_type.dart';
import 'package:crocodile_game/app/model/word_item.dart';
import 'package:crocodile_game/app/model/category_item.dart';

class LocalRandomWordsProvider implements RandomWordsProviderType {

  @override
  Future<List<WordItem>> getAllWords(String jsonData) async {
    var data = json.decode(jsonData);
    var jsonWords = data["words"];

    List<WordItem> items = [];
    for (var model in jsonWords) {
      items.add(new WordItem.fromMap(model));
    }

    return Future.value(items);
  }

  @override
  Future<List<WordItem>> getWordsByCategories(List<CategoryItem> categories) {
    return Future.value();
  }

}
