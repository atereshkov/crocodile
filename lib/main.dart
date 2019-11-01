import 'package:flutter/material.dart';
import 'package:crocodile_game/app/core/application.dart';
import 'package:injector/injector.dart';

void main() async {
  final injector = Injector();
  var application = GameApplication(injector);
  await application.onCreate();
  runApp(application.component);
}