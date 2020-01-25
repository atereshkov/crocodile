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
        TeamPlayMode mode = snapshot.data;
        switch (mode) {
          case TeamPlayMode.prepare:
          return _buildPrepareMode(context);
          case TeamPlayMode.game:
          return _buildGameMode(context);
          case TeamPlayMode.results:
          return _buildResultsMode(context);
        }
      }
    );
  }

  Widget _buildPrepareMode(BuildContext context) {
    return Text('Prepare');
  }

  Widget _buildGameMode(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            children: <Widget>[
              _gradientBackground(),
              Center(
                child: _buildActionContent(context),
              ),
            ],
          ),
        ),
        Image(
          image: AssetImage("resources/images/source2.gif"),
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

  Widget _buildResultsMode(BuildContext context) {
    return Text('Results');
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

  Widget _buildActionContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildWord(context),
        Padding(padding: EdgeInsets.only(top: 16)),
        _buildNextWordButton(context),
      ],
    );
  }

  Widget _buildWord(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.item,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 27,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.grey.shade900.withOpacity(0.5),
                  offset: Offset(1.0, 1.0),
                  blurRadius: 5.0,
                ),
              ],
            ),
          );
        } else {
          return Text(
            "Loading",
            style: TextStyle(
              color: Colors.white
            ),
          );
        }
      }
    );
  }

  Widget _buildNextWordButton(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.5; 
    double height = MediaQuery.of(context).size.height * 0.06;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: width,
        minHeight: height,
      ),
      child: RaisedButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: Text(
          AppLocalizations.of(context).singlePlayNextWordButton,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        onPressed: () {
          widget._viewModel.generateNewWordAction(context);
        },
      ),
    );
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