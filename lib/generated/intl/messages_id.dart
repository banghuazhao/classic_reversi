// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a id locale. All the
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
  String get localeName => 'id';

  static String m0(wins, losses) => "Menang ${wins} · Kalah ${losses}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Black": MessageLookupByLibrary.simpleMessage("hitam"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Hitam menang"),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage("Classic Reversi"),
    "Difficulty": MessageLookupByLibrary.simpleMessage("Tingkat Kesulitan"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("Mudah"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("Sulit"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("Sedang"),
    "FirstPlayerComputer": MessageLookupByLibrary.simpleMessage("Komputer"),
    "FirstPlayerHuman": MessageLookupByLibrary.simpleMessage("Pemain"),
    "FirstPlayerRandom": MessageLookupByLibrary.simpleMessage("Acak"),
    "How_to_play": MessageLookupByLibrary.simpleMessage("Cara bermain?"),
    "How_to_play_explain": MessageLookupByLibrary.simpleMessage(
      "Dalam permainan ini, semua keping lawan yang berada dalam satu garis lurus dan diapit oleh keping yang baru diletakkan dan keping lain milik pemain saat ini akan dibalik menjadi warna pemain saat ini. Tujuan permainan adalah memiliki mayoritas keping dengan warna Anda saat kotak kosong terakhir yang bisa dimainkan terisi.",
    ),
    "More": MessageLookupByLibrary.simpleMessage("Lainnya"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("Aplikasi Lainnya"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Main melawan teman di perangkat ini",
    ),
    "StartGame": MessageLookupByLibrary.simpleMessage("Mulai Permainan"),
    "Tie": MessageLookupByLibrary.simpleMessage("Seri"),
    "TwoPlayersMode": MessageLookupByLibrary.simpleMessage(
      "2 Pemain (main bergantian)",
    ),
    "White": MessageLookupByLibrary.simpleMessage("putih"),
    "WhiteWins": MessageLookupByLibrary.simpleMessage("Putih menang"),
    "WhoGoesFirst": MessageLookupByLibrary.simpleMessage(
      "Siapa yang jalan duluan?",
    ),
    "WinsLosses": m0,
  };
}
