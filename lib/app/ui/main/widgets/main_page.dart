import 'package:flutter/material.dart';
import 'package:crocodile_game/app/ui/main/view_model/main_view_model_type.dart';

class MainPage extends StatefulWidget {
  final MainViewModelType _viewModel;

  MainPage(this._viewModel);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    super.initState();
    _buildViewModel();
  }

  @override
  void dispose() {
    widget._viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(title: Text('Title'));
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60),
      child: Center(
        child: Column(
          children: <Widget>[
            _buildSinglePlayRow(context),
            Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            _buildHowToPlayButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSinglePlayRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSinglePlayButton(context),
        // Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
        // _buildSinglePlayHelpIcon(context),
      ],
    );
  }

  Widget _buildTeamPlayRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildTeamPlayButton(context),
        Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
        _buildTeamPlayHelpIcon(context),
      ],
    );
  }

  Widget _buildSinglePlayButton(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey)
      ),
      onPressed: () {
        widget._viewModel.singlePlayAction(context);
      },
      child: Text("Single Mode"),
    );
  }

  Widget _buildSinglePlayHelpIcon(BuildContext context) {
    return ButtonTheme(
      minWidth: 40,
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey)
        ),
        onPressed: () {
          
        },
        child: Text("?"),
      ),
    );
  }

  Widget _buildTeamPlayButton(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey)
      ),
      onPressed: () {
        widget._viewModel.singlePlayAction(context);
      },
      child: Text("Team Mode"),
    );
  }

  Widget _buildTeamPlayHelpIcon(BuildContext context) {
    return ButtonTheme(
      minWidth: 40,
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey)
        ),
        onPressed: () {
          
        },
        child: Text("?"),
      ),
    );
  }

  Widget _buildHowToPlayButton(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey)
      ),
      onPressed: () {
        widget._viewModel.howToPlayAction(context);
      },
      child: Text("How to play?"),
    );
  }

  void _buildViewModel() {

  }

}