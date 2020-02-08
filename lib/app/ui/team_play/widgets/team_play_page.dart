import 'package:crocodile_game/app/ui/team_play/widgets/mode_game_widget.dart';
import 'package:crocodile_game/app/ui/team_play/widgets/mode_prepare_widget.dart';
import 'package:crocodile_game/app/ui/team_play/widgets/mode_next_team_widget.dart';
import 'package:crocodile_game/app/ui/team_play/widgets/mode_results_widget.dart';
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _buildViewModel();
    Future.delayed(Duration.zero, () {
      widget._viewModel.initState(context);
      _bindViewModel(context);
    });
  }

  void _bindViewModel(BuildContext context) async {
    widget._viewModel.onSnackBarMessage.listen((message) {
      final snackBar = SnackBar(
          content: Text(
            message.text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: message.color,
          duration: Duration(seconds: 2),
        );

        _scaffoldKey.currentState.showSnackBar(snackBar);
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
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Team Play'),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder(
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          ),
        ),
        Container(
          width: double.maxFinite,
          color: Color(0xffC1ECFC),
          child: SafeArea(
            child: AdmobBanner(
              adUnitId: getBottomBannerId(),
              adSize: AdmobBannerSize.BANNER,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrepareMode(BuildContext context) {
    return PrepareModeWidget(widget._viewModel);
  }

  Widget _buildActMode(BuildContext context) {
    return GameModeWidget(widget._viewModel);
  }

  Widget _buildNextTeamMode(BuildContext context) {
    return NextTeamModeWidget(widget._viewModel);
  }

  Widget _buildResultsMode(BuildContext context) {
    return ResultsModeWidget(widget._viewModel);
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