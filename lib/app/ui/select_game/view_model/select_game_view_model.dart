import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:crocodile_game/app/ui/select_game/module.dart';
import 'package:crocodile_game/app/ui/single_play/module.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/provider/providers.dart';
import 'package:crocodile_game/app/service/services.dart';

class SelectGameViewModel implements SelectGameViewModelType {

  final Injector _injector;
  final List<CategoryInfoItem> currentCategories = [];

  CategoryProviderType _categoryProvider;
  RemoteAnalyticsServiceType _remoteAnalyticsService;

  final _itemsController = BehaviorSubject<List<CategoryInfoItem>>();
  final _startButtonEnabledController = BehaviorSubject<bool>();

  SelectGameViewModel(this._injector) {
    _categoryProvider = _injector.getDependency<CategoryProviderType>();
    _remoteAnalyticsService = _injector.getDependency<RemoteAnalyticsServiceType>();
  }

  @override
  Stream<List<CategoryInfoItem>> get getItemsStream => _itemsController.stream;

  @override
  Stream<bool> get startGameButtonEnabledStream => _startButtonEnabledController.stream;

  @override
  List<CategoryInfoItem> selectedItems;

  @override
  bool isItemSelected(CategoryInfoItem item) {
    final selected = currentCategories.firstWhere((i) => i.id == item.id, orElse: () => null);
    return selected == null ? false : true;
  }

  @override
  void initState(BuildContext context) async {
    _categoryProvider.getAllCategories(context).then((categories) {
      // tick first category as default one
      currentCategories.add(categories.first);

      // enable start button by default if current categories is not empty
      _startButtonEnabledController.sink.add(currentCategories.isNotEmpty);

      // add all the categories to items
      _itemsController.sink.add(categories);
    });
  }

  @override
  void handleTap(CategoryInfoItem item) async {
    if (!isItemSelected(item)) {
      currentCategories.add(item);
    } else {
      final int index = currentCategories.indexWhere((i) => i.id == item.id);
      currentCategories.removeAt(index);
    }
    _itemsController.first.then((items) {
      _itemsController.sink.add(items);
    });

    _startButtonEnabledController.sink.add(currentCategories.isNotEmpty);
  }

  @override
  void startGameAction(BuildContext context) {
    AnalyticsEventType event = RemoteAnalyticsEvent(name: "open_screen", parameters: { 'screen': 'single_play', 'from': 'main' });
    _remoteAnalyticsService.sendAnalyticsEvent(event);
    SinglePlayViewModelType vm = SinglePlayViewModel(_injector, currentCategories);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SinglePlayPage(vm)));
  }

  @override
  void dispose() {
    _itemsController.close();
    _startButtonEnabledController.close();
  }

}
