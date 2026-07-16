// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(wins, losses) => "Vittorie ${wins} · Sconfitte ${losses}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Black": MessageLookupByLibrary.simpleMessage("nero"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Vince il nero"),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage("Classic Reversi"),
    "Difficulty": MessageLookupByLibrary.simpleMessage("Difficoltà"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("Facile"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("Difficile"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("Medio"),
    "FirstPlayerComputer": MessageLookupByLibrary.simpleMessage("Computer"),
    "FirstPlayerHuman": MessageLookupByLibrary.simpleMessage("Giocatore"),
    "FirstPlayerRandom": MessageLookupByLibrary.simpleMessage("Casuale"),
    "How_to_play": MessageLookupByLibrary.simpleMessage("Come si gioca?"),
    "How_to_play_explain": MessageLookupByLibrary.simpleMessage(
      "Nel gioco, tutti i dischi dell\'avversario allineati e compresi tra il disco appena posizionato e un altro disco del giocatore corrente vengono capovolti nel colore del giocatore corrente. L\'obiettivo del gioco è avere la maggioranza dei dischi del proprio colore quando l\'ultima casella vuota giocabile viene riempita.",
    ),
    "More": MessageLookupByLibrary.simpleMessage("Altro"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("Altre App"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Gioca con un amico su questo dispositivo",
    ),
    "StartGame": MessageLookupByLibrary.simpleMessage("Inizia partita"),
    "Tie": MessageLookupByLibrary.simpleMessage("Pareggio"),
    "TwoPlayersMode": MessageLookupByLibrary.simpleMessage(
      "2 giocatori (a turno)",
    ),
    "White": MessageLookupByLibrary.simpleMessage("bianco"),
    "WhiteWins": MessageLookupByLibrary.simpleMessage("Vince il bianco"),
    "WhoGoesFirst": MessageLookupByLibrary.simpleMessage("Chi inizia?"),
    "WinsLosses": m0,
  };
}
