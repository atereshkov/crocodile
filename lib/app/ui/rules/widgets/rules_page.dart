import 'package:crocodile_game/app/localization/app_localizations.dart';
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
    return AppBar(
      title: Text(AppLocalizations.of(context).rulesTitle),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        _gradientBackground(),
        Column(
          children: <Widget>[
            _buildSinglePlayRules(context),
            _buildTeamPlayRules(context),
          ],
        ),
      ],
    );
  }

  Widget _buildSinglePlayRules(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.person,
                color: Colors.blue,
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Icon(
                Icons.person,
                color: Colors.blue,
              ),
              Padding(padding: EdgeInsets.only(left: 12)),
              Text(
                AppLocalizations.of(context).rulesSingleModeSubtitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 12)),
          Text(
            AppLocalizations.of(context).rulesSingleModeContent,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamPlayRules(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.people,
                color: Colors.blue,
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Icon(
                Icons.people,
                color: Colors.blue,
              ),
              Padding(padding: EdgeInsets.only(left: 12)),
              Text(
                AppLocalizations.of(context).rulesTeamModeSubtitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 12)),
          Text(
            AppLocalizations.of(context).rulesTeamModeContent,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _gradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white]
        )
      ),
    );
  }

}