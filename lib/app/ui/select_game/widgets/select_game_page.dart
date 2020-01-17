import 'package:crocodile_game/app/localization/app_localizations.dart';
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

    Future.delayed(Duration.zero, () {
      widget._viewModel.initState(context);
    });

    super.initState();
  }

  void _bindViewModel() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).selectGameTitle),
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
        Expanded(
          child: _buildList(context),
        ),
        _buildBottomContainer(context),
      ],
    );
  }

  Widget _buildGameType(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildSinglePlayIcon(context),
            Padding(padding: EdgeInsets.only(top: 4)),
            Text(AppLocalizations.of(context).selectGameSinglePlay),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildTeamPlayIcon(context),
            Padding(padding: EdgeInsets.only(top: 4)),
            Text(AppLocalizations.of(context).selectGameTeamPlay),
          ],
        ),
      ],
    );
  }

  Widget _buildSinglePlayIcon(BuildContext context) {
    double containerSize = MediaQuery.of(context).size.width * 0.2;
    
    return Container(
      width: containerSize,
      height: containerSize,
      color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.person, color: Colors.white70),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person, color: Colors.white),
              Icon(Icons.person, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamPlayIcon(BuildContext context) {
    double containerSize = MediaQuery.of(context).size.width * 0.2;

    return Container(
      width: containerSize,
      height: containerSize,
      color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.person, color: Colors.white70),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.people, color: Colors.white),
              Icon(Icons.people, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.getItemsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CategoryInfoItem> items = snapshot.data;
          return Scrollbar(
            child: ListView.separated(
              key: PageStorageKey('select-category-page-key'),
              separatorBuilder: (context, index) {
                return Divider(indent: 12, height: 2.0);
              },
              itemBuilder: (BuildContext context, int index) {
                CategoryInfoItem item = items[index];
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

  Widget _buildItem(BuildContext context, CategoryInfoItem item) {
    final bool isItemSelected = widget._viewModel.isItemSelected(item);
    return InkWell(
      onTap: () {
        widget._viewModel.handleTap(item);
      },
      child: CategoryItemWidget(item: item, isSelected: isItemSelected),
    );
  }

  Widget _buildBottomContainer(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 20.0,
                spreadRadius: 5.0,
              )
            ],
          ),
          height: 50,
          width: double.infinity,
          child: _buildStartGameButton(context),
        ),
        Container(
          height: MediaQuery.of(context).padding.bottom,
          color: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildStartGameButton(BuildContext context) {
    return InkWell(
      onTap: () {
        widget._viewModel.startGameAction(context);
      },
      child: Container(
        color: Colors.orange,
        child: Center(
          child: Text(
            AppLocalizations.of(context).selectGameStartGameButton,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

}
