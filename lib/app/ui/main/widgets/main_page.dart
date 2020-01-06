import 'package:flutter/material.dart';
import 'package:crocodile_game/app/ui/main/view_model/main_view_model_type.dart';

import 'dart:io' show Platform;
import 'package:admob_flutter/admob_flutter.dart';

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
      // extendBodyBehindAppBar: true,
      // appBar: _buildAppBar(context),
      body: _buildBody(context),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Title',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
          image: AssetImage('resources/images/cloud-sky.png'),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              _gradientBackground(),
              SafeArea(
                child: Column(
                  children: <Widget>[
                    // TODO: Logo
                    _buildMenu(context),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image(
            image: AssetImage("resources/images/main_croco.gif"),
          ),
        ),
        AdmobBanner(
          adUnitId: getBottomBannerId(),
          adSize: AdmobBannerSize.BANNER,
        )
      ],
    );
  }

  Widget _gradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff06b6ff), Colors.white]
        )
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          _buildSinglePlayButton(context),
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          _buildHowToPlayButton(context),
        ],
      ),
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
      ),
      onPressed: () {
        widget._viewModel.singlePlayAction(context);
      },
      child: Text(
        "Play",
        style: TextStyle(
          fontSize: 19,
        ),
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
      ),
      onPressed: () {
        
      },
      child: Text(
        "How To Play",
        style: TextStyle(
          fontSize: 19,
        ),
      ),
    );
  }

  void _buildViewModel() {

  }

  String getBottomBannerId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-4667215880477199/2013054477";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4667215880477199/9626345834";
    } else {
      return "";
    }
  }

}