import 'package:crocodile_game/app/model/models.dart';

abstract class SelectGameViewModelType {
  Stream<List<CategoryItem>> get getItemsStream;
  List<CategoryItem> get selectedItems;
  bool isItemSelected(CategoryItem item);

  void handleTap(CategoryItem item);

  void initState();
  void dispose();
}