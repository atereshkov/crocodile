import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:crocodile_game/app/ui/select_game/module.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/provider/providers.dart';

class SelectGameViewModel implements SelectGameViewModelType {

  final Injector _injector;
  final List<CategoryItem> currentCategories;

  CategoryProviderType _categoryProvider;

  final _itemsController = BehaviorSubject<List<CategoryItem>>();

  SelectGameViewModel(this._injector, this.currentCategories) {
    _categoryProvider = _injector.getDependency<CategoryProviderType>();
  }

  @override
  Stream<List<CategoryItem>> get getItemsStream => _itemsController.stream;

  @override
  List<CategoryItem> selectedItems;

  @override
  bool isItemSelected(CategoryItem item) {
    final selected = currentCategories.firstWhere((i) => i.id == item.id, orElse: () => null);
    return selected == null ? false : true;
  }

  @override
  void initState() async {
    _categoryProvider.getAllCategories().then((categories) {
      _itemsController.sink.add(categories);
    });
  }

  @override
  void handleTap(CategoryItem item) async {
    if (!isItemSelected(item)) {
      currentCategories.add(item);
    } else {
      final int index = currentCategories.indexWhere((i) => i.id == item.id);
      currentCategories.removeAt(index);
    }
    _itemsController.first.then((items) {
      _itemsController.sink.add(items);
    });
  }

  @override
  void dispose() {
    _itemsController.close();
  }

}
