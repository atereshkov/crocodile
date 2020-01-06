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

  // Main:
  String get mainMenuPlaySingleMode => Intl.message('Play', name: 'mainMenuPlaySingleMode');
  String get mainMenuHowToPlay => Intl.message('How To Play', name: 'mainMenuHowToPlay');
  
  // Rules:
  String get rulesTitle => Intl.message('Rules', name: 'rulesTitle');
  String get rulesSingleModeSubtitle => Intl.message('Single mode', name: 'rulesSingleModeSubtitle');
  String get rulesTeamModeSubtitle => Intl.message('Team mode', name: 'rulesTeamModeSubtitle');
  String get rulesSingleModeContent => Intl.message('The player must depict the word using only gestures and facial expressions (you can’t speak), and the rest of the players must guess the word. The one who guessed the word takes the place of the leading player and the game continues.', name: 'rulesSingleModeContent');
  String get rulesTeamModeContent => Intl.message('Players are divided into teams with any number of players. Then the teams show the words one by one (one player from the team). The player shows the word and only his team tries to guess the word. If a word is guessed within the time, points are awarded to the team and the line goes to the next team in a circle.', name: 'rulesTeamModeContent');

  // Single mode
  String get singlePlayTitle => Intl.message('Game', name: 'singlePlayTitle');
  String get singlePlayNextWordButton => Intl.message('Next Word', name: 'singlePlayNextWordButton');
  
}