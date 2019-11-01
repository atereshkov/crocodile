import 'package:flutter/material.dart';
import 'package:crocodile_game/app/localization/app_localizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate({
    this.isTest = false,
  });

  final bool isTest;

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    if (isTest) {
      return AppLocalizations.loadTest(locale);
    } else {
      return AppLocalizations.load(locale);
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
