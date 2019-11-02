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
    _buildViewModel();
    widget._viewModel.initState();
    super.initState();
  }

  @override
  void dispose() {
    widget._viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Title')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Text('Kek'),
    );
  }

  void _buildViewModel() {

  }

}