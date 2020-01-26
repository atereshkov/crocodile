import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crocodile_game/app/provider/random_words_provider_type.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/localization/app_localizations.dart';

class LocalRandomWordsProvider implements RandomWordsProviderType {

  @override
  Future<List<WordItem>> getAllWords(BuildContext context) async {
    var jsonWords = await _getJsonWords(context);

    List<WordItem> items = [];
    for (var model in jsonWords) {
      WordItem item = WordItem.fromMap(model);
      items.add(item);
    }

    return Future.value(items);
  }

  @override
  Future<List<WordItem>> getWordsByCategories(List<CategoryInfoItem> categories, BuildContext context) async {
    var jsonWords = await _getJsonWords(context);

    List<WordItem> items = [];
    for (var model in jsonWords) {
      WordItem item = WordItem.fromMap(model);
      for (CategoryInfoItem category in categories) {
        var commonCategory = item.categories.firstWhere((cat) => cat.id == category.id, orElse: () => null);
        if (commonCategory != null) {
          items.add(item);
        }
      }
    }

    return Future.value(items);
  }

  Future<dynamic> _getJsonWords(BuildContext context) async {
    String lang = AppLocalizations.of(context).getCurrentLangCode;
    String resourceFile = 'resources/words_$lang.json';
    String jsonData = await DefaultAssetBundle.of(context).loadString(resourceFile);

    var data = json.decode(jsonData);
    return data["words"];
  }

}
