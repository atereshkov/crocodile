import 'package:flutter/material.dart';
import 'package:crocodile_game/app/core/application.dart';
import 'package:injector/injector.dart';

import 'dart:io' show Platform;
import 'package:admob_flutter/admob_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize(getAdAppId());

  final injector = Injector();
  var application = GameApplication(injector);
  await application.onCreate();
  runApp(application.component);
}

String getAdAppId() {
  if (Platform.isAndroid) {
    return "ca-app-pub-4667215880477199~3326136141";
  } else if (Platform.isIOS) {
    return "ca-app-pub-4667215880477199~8556015789";
  } else {
    return "";
  }
}