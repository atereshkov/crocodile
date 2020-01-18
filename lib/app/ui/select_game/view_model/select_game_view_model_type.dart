import 'package:crocodile_game/app/model/enum/enums.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:flutter/material.dart';

abstract class SelectGameViewModelType {
  Stream<List<CategoryInfoItem>> get getItemsStream;
  Stream<bool> get startGameButtonEnabledStream;
  Stream<GameType> get currentGameTypeStream;

  List<CategoryInfoItem> get selectedItems;
  bool isItemSelected(CategoryInfoItem item);

  void startGameAction(BuildContext context);
  void handleTap(CategoryInfoItem item);
  void handleGameTypeTap(GameType type);

  void initState(BuildContext context);
  void dispose();
}