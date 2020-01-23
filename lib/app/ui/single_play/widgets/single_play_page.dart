import 'package:crocodile_game/app/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:crocodile_game/app/ui/single_play/view_model/single_play_view_model_type.dart';

import 'dart:io' show Platform;
import 'package:admob_flutter/admob_flutter.dart';

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
    return AppBar(
      title: Text(AppLocalizations.of(context).singlePlayTitle),
    );
  }

  Widget _buildBody(BuildContext context) {
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
        AdmobBanner(
          adUnitId: getBottomBannerId(),
          adSize: AdmobBannerSize.BANNER,
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
      return "ca-app-pub-4667215880477199/9071919868";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4667215880477199/8928449638";
    } else {
      return "";
    }
  }

}