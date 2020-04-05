import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crocodile_game/app/service/services.dart';
import 'package:crocodile_game/app/model/models.dart';
import 'package:crocodile_game/app/localization/app_localizations.dart';

class AppLanguageService implements AppLanguageServiceType {

  AppLanguageService();

  @override
  Future<Language> getCurrentAppLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString('app_lang');

    if (jsonString != null) {
      Map<String, dynamic> jsonObject = jsonDecode(jsonString);
      Language object = Language.fromMap(jsonObject);
      return object;
    }
    
    return null;
  }

  @override
  Future<void> switchAppLanguage(Language language) async {
    AppLocalizations.load(Locale(language.code, language.country));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(language);
    prefs.setString('app_lang', json);
  }

}
