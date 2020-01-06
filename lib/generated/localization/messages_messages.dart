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
    "mainMenuHowToPlay" : MessageLookupByLibrary.simpleMessage("How To Play"),
    "mainMenuPlaySingleMode" : MessageLookupByLibrary.simpleMessage("Play"),
    "rulesSingleModeContent" : MessageLookupByLibrary.simpleMessage("Игрок должен изобразить слово, используя только жесты и мимику (говорить нельзя), а остальные игроки должны угадать это слово. Тот, кто угадал - занимает место ведущего игрока и игра продолжается."),
    "rulesSingleModeSubtitle" : MessageLookupByLibrary.simpleMessage("Обычная игра"),
    "rulesTeamModeContent" : MessageLookupByLibrary.simpleMessage("Игроки делятся на команды с произвольным количеством игроков. Далее команды по кругу показывают слова (один игрок от команды). Игрок показывает слово и только его команда пытается отгадать слово. Если слово отгадано за отведенное время, команде начисляются баллы и очередь переходит к следущей команде по кругу."),
    "rulesTeamModeSubtitle" : MessageLookupByLibrary.simpleMessage("Командная игра"),
    "rulesTitle" : MessageLookupByLibrary.simpleMessage("Rules")
  };
}
