import 'package:crocodile_game/app/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:crocodile_game/app/ui/team_play/module.dart';

import 'dart:io' show Platform;
import 'package:admob_flutter/admob_flutter.dart';

class TeamPlayPage extends StatefulWidget {
  final TeamPlayViewModelType _viewModel;

  TeamPlayPage(this._viewModel);

  @override
  _TeamPlayPageState createState() => _TeamPlayPageState();
}

class _TeamPlayPageState extends State<TeamPlayPage> {

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
    return AppBar(
      title: Text(AppLocalizations.of(context).singlePlayTitle),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container();
  }

  void _buildViewModel() {

  }

  String getBottomBannerId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-4667215880477199/9071919868";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4667215880477199/8928449638";
    } else {
      return "";
    }
  }

}