import 'package:flutter/material.dart';
import 'package:crocodile_game/app/localization/app_localizations.dart';
import 'package:crocodile_game/app/ui/team_play/module.dart';
import 'package:crocodile_game/app/model/enum/enums.dart';

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
    return StreamBuilder(
      stream: widget._viewModel.mode,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          TeamPlayMode mode = snapshot.data;
          switch (mode) {
            case TeamPlayMode.start:
              return _buildPrepareMode(context);
            case TeamPlayMode.act:
              return _buildActMode(context);
            case TeamPlayMode.nextTeam:
              return _buildNextTeamMode(context);
            case TeamPlayMode.results:
              return _buildResultsMode(context);
          }
        } else {
          return Container();
        }
      }
    );
  }

  Widget _buildPrepareMode(BuildContext context) {
    return Text('Prepare');
  }

  Widget _buildActMode(BuildContext context) {
    return Text('Act');
  }

  Widget _buildNextTeamMode(BuildContext context) {
    return Text('Next team');
  }

  Widget _buildResultsMode(BuildContext context) {
    return Text('Results');
  }
  
  void _buildViewModel() {

  }

  String getBottomBannerId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-4667215880477199/8333965958";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4667215880477199/6693581224";
    } else {
      return "";
    }
  }

}