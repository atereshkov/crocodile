// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "categoryAbstract" : MessageLookupByLibrary.simpleMessage("Abstract"),
    "categoryAbstractDescription" : MessageLookupByLibrary.simpleMessage("The hardest words to show (e.g., approach, logics, illustration, baroque)."),
    "categoryEasy" : MessageLookupByLibrary.simpleMessage("Easy"),
    "categoryEasyDescription" : MessageLookupByLibrary.simpleMessage("Simple words (e.g., dog, laptop, char, bird, soldier, etc)."),
    "categoryHard" : MessageLookupByLibrary.simpleMessage("Hard"),
    "categoryHardDescription" : MessageLookupByLibrary.simpleMessage("Complicated words (e.g., contract, police department, blue hippo, electrician, etc)."),
    "categoryMedium" : MessageLookupByLibrary.simpleMessage("Medium"),
    "categoryMediumDescription" : MessageLookupByLibrary.simpleMessage("Not easy and not really hard (e.g., drama, squirrel, pancakes, tractor driver, etc)."),
    "mainMenuHowToPlay" : MessageLookupByLibrary.simpleMessage("How To Play"),
    "mainMenuPlaySingleMode" : MessageLookupByLibrary.simpleMessage("Play"),
    "rulesSingleModeContent" : MessageLookupByLibrary.simpleMessage("The player must depict the word using only gestures and facial expressions (you can’t speak), and the rest of the players must guess the word. The one who guessed the word takes the place of the leading player and the game continues."),
    "rulesSingleModeSubtitle" : MessageLookupByLibrary.simpleMessage("Single mode"),
    "rulesTeamModeContent" : MessageLookupByLibrary.simpleMessage("Players are divided into teams with any number of players. Then the teams show the words one by one (one player from the team). The player shows the word and only his team tries to guess the word. If a word is guessed within the time, points are awarded to the team and the line goes to the next team in a circle."),
    "rulesTeamModeSubtitle" : MessageLookupByLibrary.simpleMessage("Team mode"),
    "rulesTitle" : MessageLookupByLibrary.simpleMessage("Rules"),
    "singlePlayNextWordButton" : MessageLookupByLibrary.simpleMessage("Next Word"),
    "singlePlayTitle" : MessageLookupByLibrary.simpleMessage("Game")
  };
}
