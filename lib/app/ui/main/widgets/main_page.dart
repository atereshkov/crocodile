import 'package:crocodile_game/app/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:crocodile_game/app/ui/main/module.dart';
import 'package:crocodile_game/app/model/models.dart';

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
    widget._viewModel.initState();
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
    double bottomAnimationHeight = MediaQuery.of(context).size.height * 0.25; 

    return Column(
      children: <Widget>[
        Image(
          image: AssetImage('resources/images/cloud-sky.png'),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              _gradientBackground(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 4, right: 16),
                    child: _buildLanguagePicker(context),
                  ),
                ],
              ),
              Center(
                child: _buildMenu(context),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image(
            height: bottomAnimationHeight,
            image: AssetImage("resources/images/main_croco.gif"),
          ),
        ),
        AdmobBanner(
          adUnitId: getBottomBannerId(),
          adSize: AdmobBannerSize.BANNER,
        ),
      ],
    );
  }

  Widget _buildLanguagePicker(BuildContext context) {
    return FutureBuilder(
      future: widget._viewModel.languages,
      builder: (BuildContext context, AsyncSnapshot<List<Language>> snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data;
          return _buildLanguagePickerDropDown(context, items);
        } else {
          return Text('Loading');
        }
      }
    );
  }

  // Widget _buildLanguagePickerDropDown(BuildContext context, List<Language> items) {
  //   return Text("Text3 ${items.length}");
  // }

  Widget _buildLanguagePickerDropDown(BuildContext context, List<Language> items) {
    return DropdownButton(
      underline: SizedBox(),
      icon: Image(
        width: 24,
        image: AssetImage('resources/icons/flag_lang_${AppLocalizations.of(context).getCurrentLangCode}.png'),
      ),
      items: items.map((lang) {
        return DropdownMenuItem<Language>(
          value: lang,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image(
                width: 24,
                image: AssetImage('resources/icons/flag_lang_${lang.code}.png'),
              ),
              Text(lang.name),
            ],
          ),
          );
        }).toList(),
      onChanged: (value) {
        setState(() {
          widget._viewModel.languageDropDownAction(value);
        });
      },
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSinglePlayButton(context),
        Padding(padding: EdgeInsets.symmetric(vertical: 4)),
        _buildHowToPlayButton(context),
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
        AppLocalizations.of(context).mainMenuPlaySingleMode,
        style: TextStyle(
          fontSize: 19, 
        ),
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
        widget._viewModel.howToPlayAction(context);
      },
      child: Text(
        AppLocalizations.of(context).mainMenuHowToPlay,
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