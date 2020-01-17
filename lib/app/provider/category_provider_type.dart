import 'package:crocodile_game/app/model/models.dart';
import 'package:flutter/material.dart';

abstract class CategoryProviderType {
  Future<List<CategoryInfoItem>> getAllCategories(BuildContext context);
}
