import 'package:injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:crocodile_game/app/core/app_component.dart';
import 'package:crocodile_game/app/core/session/session.dart';
import 'package:crocodile_game/app/ui/main/module.dart';

abstract class Application {

  AppComponent component;
  Widget homeWidget;

  void onCreate();
  void onTerminate();
}

class GameApplication implements Application {

  final Injector _injector;

  GameApplication(this._injector);

  @override
  AppComponent component;

  @override
  Widget homeWidget;

  @override
  Future<void> onCreate() async {
    Session session = Session();
    session.registerDependencies(_injector);

    MainViewModelType syncViewModel = MainViewModel(_injector);
    homeWidget = MainPage(syncViewModel);
    component = AppComponent(this, _injector);
  }

  @override
  Future<void> onTerminate() async {

  }

}