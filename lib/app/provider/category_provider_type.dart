import 'package:crocodile_game/app/model/models.dart';

abstract class CategoryProviderType {
  Future<List<CategoryItem>> getAllCategories();
}
