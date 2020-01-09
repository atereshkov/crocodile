import 'package:flutter/material.dart';
import 'package:crocodile_game/app/model/models.dart';

abstract class SinglePlayViewModelType {
  Stream<String> get item;
  List<CategoryItem> selectedCategories;

  void initState(BuildContext context);
  void generateNewWordAction(BuildContext context);
  void dispose();
}