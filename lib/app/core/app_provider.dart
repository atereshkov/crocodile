import 'package:flutter/material.dart';
import 'package:crocodile_game/app/core/application.dart';

class AppProvider extends InheritedWidget {

  final GameApplication application;

  AppProvider({Key key, Widget child, this.application})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

}
