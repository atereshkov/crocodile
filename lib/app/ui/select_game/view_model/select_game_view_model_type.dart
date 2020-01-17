import 'package:crocodile_game/app/model/models.dart';
import 'package:flutter/material.dart';

abstract class SelectGameViewModelType {
  Stream<List<CategoryInfoItem>> get getItemsStream;
  Stream<bool> get startGameButtonEnabledStream;

  List<CategoryInfoItem> get selectedItems;
  bool isItemSelected(CategoryInfoItem item);

  void startGameAction(BuildContext context);
  void handleTap(CategoryInfoItem item);

  void initState(BuildContext context);
  void dispose();
}