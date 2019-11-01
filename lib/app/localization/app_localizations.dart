import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crocodile_game/generated/localization/messages_all.dart';

class AppLocalizations {

  static AppLocalizations of(BuildContext context) => Localizations.of<AppLocalizations>(context, AppLocalizations);

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static Future<AppLocalizations> loadTest(Locale locale) async {
    return AppLocalizations();
  }

  String get getCurrentLangCode => Intl.shortLocale(Intl.defaultLocale);

  // String get loginScreenTitle => Intl.message('Login', name: 'loginScreenTitle');
  
}