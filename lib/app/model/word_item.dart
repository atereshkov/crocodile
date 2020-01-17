import 'package:crocodile_game/app/model/category_item.dart';

class WordItem {
  final String word;
  final List<CategoryItem> categories;

  WordItem({this.word, this.categories});

  factory WordItem.fromMap(Map<String, dynamic> map) {
    var categoriesList = map['categories'] as List;
    List<CategoryItem> categories = categoriesList.map((i) => CategoryItem.fromMap(i['category'])).toList();

    return WordItem(
      word: map['word'],
      categories: categories
    );
  }

}