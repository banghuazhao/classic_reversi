// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
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
  String get localeName => 'vi';

  static String m0(wins, losses) => "Thắng ${wins} · Thua ${losses}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Black": MessageLookupByLibrary.simpleMessage("đen"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Quân đen thắng"),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage("Cờ Lật Cổ Điển"),
    "Difficulty": MessageLookupByLibrary.simpleMessage("Độ khó"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("Dễ"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("Khó"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("Trung bình"),
    "FirstPlayerComputer": MessageLookupByLibrary.simpleMessage("Máy tính"),
    "FirstPlayerHuman": MessageLookupByLibrary.simpleMessage("Người chơi"),
    "FirstPlayerRandom": MessageLookupByLibrary.simpleMessage("Ngẫu nhiên"),
    "How_to_play": MessageLookupByLibrary.simpleMessage("Cách chơi?"),
    "How_to_play_explain": MessageLookupByLibrary.simpleMessage(
      "Trong trò chơi, tất cả các quân của đối phương nằm trên một đường thẳng và bị kẹp giữa quân vừa đặt và một quân khác của người chơi hiện tại sẽ được lật sang màu của người chơi hiện tại. Mục tiêu của trò chơi là có nhiều quân mang màu của mình nhất khi ô trống có thể chơi cuối cùng được lấp đầy.",
    ),
    "More": MessageLookupByLibrary.simpleMessage("Thêm"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("Ứng dụng khác"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Chơi cùng bạn bè trên thiết bị này",
    ),
    "StartGame": MessageLookupByLibrary.simpleMessage("Bắt đầu"),
    "Tie": MessageLookupByLibrary.simpleMessage("Hòa"),
    "TwoPlayersMode": MessageLookupByLibrary.simpleMessage(
      "2 người chơi (chơi lần lượt)",
    ),
    "White": MessageLookupByLibrary.simpleMessage("trắng"),
    "WhiteWins": MessageLookupByLibrary.simpleMessage("Quân trắng thắng"),
    "WhoGoesFirst": MessageLookupByLibrary.simpleMessage("Ai đi trước?"),
    "WinsLosses": m0,
  };
}
