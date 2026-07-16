// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(wins, losses) => "Побед ${wins} · Поражений ${losses}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Black": MessageLookupByLibrary.simpleMessage("чёрные"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Чёрные побеждают"),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage(
      "Классические Реверси",
    ),
    "Difficulty": MessageLookupByLibrary.simpleMessage("Сложность"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("Лёгкий"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("Сложный"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("Средний"),
    "FirstPlayerComputer": MessageLookupByLibrary.simpleMessage("Компьютер"),
    "FirstPlayerHuman": MessageLookupByLibrary.simpleMessage("Игрок"),
    "FirstPlayerRandom": MessageLookupByLibrary.simpleMessage("Случайно"),
    "How_to_play": MessageLookupByLibrary.simpleMessage("Как играть?"),
    "How_to_play_explain": MessageLookupByLibrary.simpleMessage(
      "В игре все фишки соперника, лежащие по прямой линии между только что поставленной фишкой и другой фишкой текущего игрока, переворачиваются в цвет текущего игрока. Цель игры — к моменту заполнения последней свободной клетки иметь на доске большинство фишек своего цвета.",
    ),
    "More": MessageLookupByLibrary.simpleMessage("Ещё"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("Другие приложения"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Играть с другом на этом устройстве",
    ),
    "StartGame": MessageLookupByLibrary.simpleMessage("Начать игру"),
    "Tie": MessageLookupByLibrary.simpleMessage("Ничья"),
    "TwoPlayersMode": MessageLookupByLibrary.simpleMessage(
      "2 игрока (по очереди)",
    ),
    "White": MessageLookupByLibrary.simpleMessage("белые"),
    "WhiteWins": MessageLookupByLibrary.simpleMessage("Белые побеждают"),
    "WhoGoesFirst": MessageLookupByLibrary.simpleMessage("Кто ходит первым?"),
    "WinsLosses": m0,
  };
}
