import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:crocodile_game/app/core/application.dart';
import 'package:crocodile_game/app/core/app_provider.dart';
import 'package:crocodile_game/app/localization/app_localizations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppComponent extends StatefulWidget {

  final GameApplication _application;
  final Injector _injector;

  AppComponent(this._application, this._injector);

  @override
  State createState() {
    return new AppComponentState(_application, _injector);
  }

}

class AppComponentState extends State<AppComponent> {

  final GameApplication _application;
  final Injector _injector;

  AppComponentState(this._application, this._injector);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    await _application.onTerminate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _runApp(_application.homeWidget);
  }

  AppProvider _runApp(Widget widget) {
    final theme = ThemeData(
      primarySwatch: Colors.red,
    );

    final app = MaterialApp(
      title: 'App',
      home: widget,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: false,
      theme: theme
    );

    final appProvider = AppProvider(child: app, application: _application);
    return appProvider;
  }

}