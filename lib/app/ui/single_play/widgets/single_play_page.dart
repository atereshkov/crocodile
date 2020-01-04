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
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(title: Text('Title'));
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