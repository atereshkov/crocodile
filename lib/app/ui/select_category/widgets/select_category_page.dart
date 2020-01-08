import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/ui/select_category/module.dart';

class SelectCategoryPage extends StatefulWidget {
  final SelectCategoryViewModelType _viewModel;

  SelectCategoryPage(this._viewModel);

  @override
  _SelectCategoryPageState createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {

  @override
  void initState() {
    _bindViewModel();
    widget._viewModel.initState();
    super.initState();
  }

  void _bindViewModel() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.getItemsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CategoryItem> items = snapshot.data;
          return Scrollbar(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 9, bottom: 9),
              key: PageStorageKey('select-category-page-key'),
              separatorBuilder: (context, index) {
                return Divider(indent: 12, height: 2.0);
              },
              itemBuilder: (BuildContext context, int index) {
                CategoryItem item = items[index];
                return _buildItem(context, item);
              },
              itemCount: items == null ? 0 : items.length,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildItem(BuildContext context, CategoryItem item) {
    final bool isItemSelected = widget._viewModel.isItemSelected(item);
    return InkWell(
      onTap: () {
        widget._viewModel.handleTap(item);
      },
      child: CategoryItemWidget(item: item, isSelected: isItemSelected),
    );
  }

}
