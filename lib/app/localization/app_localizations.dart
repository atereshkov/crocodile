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

  // Categories
  String get categoryEasy => Intl.message('Easy', name: 'categoryEasy');
  String get categoryEasyDescription => Intl.message('Simple words (e.g., dog, laptop, char, bird, soldier, etc).', name: 'categoryEasyDescription');
  String get categoryMedium => Intl.message('Medium', name: 'categoryMedium');
  String get categoryMediumDescription => Intl.message('Not easy and not really hard (e.g., drama, squirrel, pancakes, tractor driver, etc).', name: 'categoryMediumDescription');
  String get categoryHard => Intl.message('Hard', name: 'categoryHard');
  String get categoryHardDescription => Intl.message('Complicated words (e.g., contract, police department, blue hippo, electrician, etc).', name: 'categoryHardDescription');
  String get categoryAbstract => Intl.message('Abstract', name: 'categoryAbstract');
  String get categoryAbstractDescription => Intl.message('The hardest words to show (e.g., approach, logics, illustration, baroque).', name: 'categoryAbstractDescription');
  
}