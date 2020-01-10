import 'package:flutter/material.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/ui/select_game/module.dart';

class SelectGamePage extends StatefulWidget {
  final SelectGameViewModelType _viewModel;

  SelectGamePage(this._viewModel);

  @override
  _SelectGamePageState createState() => _SelectGamePageState();
}

class _SelectGamePageState extends State<SelectGamePage> {

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
        title: Text('Choose game type & words'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 14),
          child: _buildGameType(context),
        ),
        Padding(padding: EdgeInsets.only(top: 6)),
        Divider(),
        Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4, left: 12),
          child: Text(
           'Choose words for the game:',
           style: TextStyle(
             fontSize: 15,
           ),
          ),
        ),
        Expanded(
          child: _buildList(context),
        ),
        _buildStartGameButton(context),
      ],
    );
  }

  Widget _buildGameType(BuildContext context) {
    double containerSize = MediaQuery.of(context).size.width * 0.2; 

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: containerSize,
              height: containerSize,
              color: Colors.orange,
            ),
            Padding(padding: EdgeInsets.only(top: 4)),
            Text('Single Play'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: containerSize,
              height: containerSize,
              color: Colors.orange,
            ),
            Padding(padding: EdgeInsets.only(top: 4)),
            Text('Team Play'),
          ],
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.getItemsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CategoryItem> items = snapshot.data;
          return Scrollbar(
            child: ListView.separated(
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

  Widget _buildStartGameButton(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 20.0,
                spreadRadius: 5.0,
              )
            ],
          ),
          height: 50,
          width: double.infinity,
          child: Container(
            color: Colors.orange,
            child: Center(
              child: Text(
                'Play',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).padding.bottom,
          color: Colors.orange,
        ),
      ],
    );
  }

}
