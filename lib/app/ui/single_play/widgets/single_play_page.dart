import 'package:flutter/material.dart';
import 'package:crocodile_game/app/ui/single_play/view_model/single_play_view_model_type.dart';

class SinglePlayPage extends StatefulWidget {
  final SinglePlayViewModelType _viewModel;

  SinglePlayPage(this._viewModel);

  @override
  _SinglePlayPageState createState() => _SinglePlayPageState();
}

class _SinglePlayPageState extends State<SinglePlayPage> {

  @override
  void initState() {
    super.initState();

    _buildViewModel();
    Future.delayed(Duration.zero, () {
      widget._viewModel.initState(context);
    });
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
      body: _buildBody2(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(title: Text('Title'));
  }

  Widget _buildBody2(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              _gradientBackground(),
            ],
          ),
        ),
        Image(
          image: AssetImage("resources/images/source2.gif"),
        ),
      ],
    );
  }

  Widget _gradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF06B6FF), Color(0xFFC1EDFA)]
        )
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildWord(context),
        FlatButton(
          child: Text("Next Word"),
          onPressed: () {
            widget._viewModel.generateNewWordAction(context);
          },
        )
      ],
    );
  }

  Widget _buildWord(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.item,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data);
        } else {
          return Text("Loading");
        }
      }
    );
  }

  void _buildViewModel() {

  }

}