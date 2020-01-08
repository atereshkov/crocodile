import 'package:crocodile_game/app/provider/providers.dart';
import 'package:crocodile_game/app/model/models.dart';

class CategoryProvider implements CategoryProviderType {

  @override
  Future<List<CategoryItem>> getAllCategories() async {
    List<CategoryItem> categories = [];

    CategoryItem easy = CategoryItem(name: 'Easy', id: 'easy');
    categories.add(easy);

    CategoryItem medium = CategoryItem(name: 'Medium', id: 'medium');
    categories.add(medium);

    CategoryItem hard = CategoryItem(name: 'Hard', id: 'hard');
    categories.add(hard);

    CategoryItem abstractCat = CategoryItem(name: 'Abstract', id: 'abstract');
    categories.add(abstractCat);

    return Future.value(categories);
  }

}