// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "categoryAbstract" : MessageLookupByLibrary.simpleMessage("Абстрактные"),
    "categoryAbstractDescription" : MessageLookupByLibrary.simpleMessage("Самые сложные слова: подход, логика, иллюстрация, барокко..."),
    "categoryEasy" : MessageLookupByLibrary.simpleMessage("Простые"),
    "categoryEasyDescription" : MessageLookupByLibrary.simpleMessage("Простые слова: собака, ноутбук, стул, птица, солдат..."),
    "categoryHard" : MessageLookupByLibrary.simpleMessage("Сложные"),
    "categoryHardDescription" : MessageLookupByLibrary.simpleMessage("Слова: контракт, полицейский участок, голубой бегемот, электрик..."),
    "categoryMedium" : MessageLookupByLibrary.simpleMessage("Средние"),
    "categoryMediumDescription" : MessageLookupByLibrary.simpleMessage("Слова посложнее: драма, белка, блины, тракторист..."),
    "mainMenuHowToPlay" : MessageLookupByLibrary.simpleMessage("Правила"),
    "mainMenuPlaySingleMode" : MessageLookupByLibrary.simpleMessage("Начать игру"),
    "rulesSingleModeContent" : MessageLookupByLibrary.simpleMessage("Игрок должен изобразить слово, используя только жесты и мимику (говорить нельзя), а остальные игроки должны угадать это слово. Тот, кто угадал - занимает место ведущего игрока и игра продолжается."),
    "rulesSingleModeSubtitle" : MessageLookupByLibrary.simpleMessage("Обычная игра"),
    "rulesTeamModeContent" : MessageLookupByLibrary.simpleMessage("Игроки делятся на команды с произвольным количеством игроков. Далее команды по кругу показывают слова (один игрок от команды). Игрок показывает слово и только его команда пытается отгадать слово. Если слово отгадано за отведенное время, команде начисляются баллы и очередь переходит к следущей команде по кругу."),
    "rulesTeamModeSubtitle" : MessageLookupByLibrary.simpleMessage("Командная игра"),
    "rulesTitle" : MessageLookupByLibrary.simpleMessage("Правила"),
    "singlePlayNextWordButton" : MessageLookupByLibrary.simpleMessage("Следующее слово"),
    "singlePlayTitle" : MessageLookupByLibrary.simpleMessage("Обычный режим")
  };
}
