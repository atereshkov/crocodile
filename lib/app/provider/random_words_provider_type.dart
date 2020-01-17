import 'package:crocodile_game/app/model/models.dart';
import 'package:flutter/material.dart';

abstract class RandomWordsProviderType {
  Future<List<WordItem>> getAllWords(BuildContext context);
  Future<List<WordItem>> getWordsByCategories(List<CategoryInfoItem> categories, BuildContext context);
}
