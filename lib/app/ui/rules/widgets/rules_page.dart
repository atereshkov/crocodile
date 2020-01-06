import 'package:flutter/material.dart';
import 'package:crocodile_game/app/ui/rules/view_model/rules_view_model_type.dart';

class RulesPage extends StatefulWidget {
  final RulesViewModelType _viewModel;

  RulesPage(this._viewModel);

  @override
  _RulesPageState createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {

  @override
  void initState() {
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
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(title: Text('Rules'));
  }

  Widget _buildBody(BuildContext context) {
    return Column();
  }

}