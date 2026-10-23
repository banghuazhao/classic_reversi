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

  static String m0(coordinate, piece) => "${coordinate}, ${piece}";

  static String m1(color) => "Máy tính · ${color}";

  static String m2(status, black, white) =>
      "${status}. Đen ${black}, trắng ${white}.";

  static String m3(color) => "Lượt quân ${color}";

  static String m4(black, white) => "Ô góc · Đen ${black} · Trắng ${white}";

  static String m5(move, total) => "Nước đi ${move} trên ${total}";

  static String m6(result, black, white, mode) =>
      "${result} · Đen ${black} – Trắng ${white} (${mode}) — Classic Reversi";

  static String m7(passed, current) =>
      "Quân ${passed} không có nước đi hợp lệ. Quân ${current} được đi tiếp.";

  static String m8(step, total) => "Bài học ${step} trên ${total}";

  static String m9(wins, losses) => "Thắng ${wins} · Thua ${losses}";

  static String m10(color) => "Bạn · ${color}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Accessibility": MessageLookupByLibrary.simpleMessage("Trợ năng"),
    "AchDailyChallenge": MessageLookupByLibrary.simpleMessage(
      "Nhà vô địch ngày",
    ),
    "AchFirstWin": MessageLookupByLibrary.simpleMessage("Chiến thắng đầu tiên"),
    "AchGames10": MessageLookupByLibrary.simpleMessage("Đã chơi 10 ván"),
    "AchGames50": MessageLookupByLibrary.simpleMessage("Đã chơi 50 ván"),
    "AchPerfectGame": MessageLookupByLibrary.simpleMessage("Ván hoàn hảo"),
    "AchWinHard": MessageLookupByLibrary.simpleMessage("Thắng mức Khó"),
    "AchWinStreak3": MessageLookupByLibrary.simpleMessage("Chuỗi 3 trận"),
    "AchWinStreak5": MessageLookupByLibrary.simpleMessage("Chuỗi 5 trận"),
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage(
      "Đã mở thành tựu",
    ),
    "Achievements": MessageLookupByLibrary.simpleMessage("Thành tựu"),
    "AdFailed": MessageLookupByLibrary.simpleMessage(
      "Quảng cáo không khả dụng. Thử lại sau.",
    ),
    "AdLoading": MessageLookupByLibrary.simpleMessage("Đang tải quảng cáo…"),
    "AdsRemoved": MessageLookupByLibrary.simpleMessage("Đã gỡ quảng cáo"),
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("Máy tính"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("Chuỗi tốt nhất"),
    "Black": MessageLookupByLibrary.simpleMessage("đen"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Quân đen thắng"),
    "BoardCell": m0,
    "BoardEmpty": MessageLookupByLibrary.simpleMessage("Ô trống"),
    "BoardKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Dùng các phím mũi tên để di chuyển trên bàn cờ, rồi nhấn Enter hoặc phím cách để đặt quân vào ô được đánh dấu.",
    ),
    "BoardLastMove": MessageLookupByLibrary.simpleMessage("Nước đi vừa rồi"),
    "BoardLegalMove": MessageLookupByLibrary.simpleMessage("Nước đi hợp lệ"),
    "BoardReviewKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Dùng các phím mũi tên để di chuyển trên bàn cờ.",
    ),
    "Cancel": MessageLookupByLibrary.simpleMessage("Hủy"),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage("Cờ Lật Cổ Điển"),
    "ComputerColor": m1,
    "ComputerThinking": MessageLookupByLibrary.simpleMessage(
      "Máy tính đang suy nghĩ…",
    ),
    "ContinueGame": MessageLookupByLibrary.simpleMessage("Tiếp tục ván chơi"),
    "CurrentStreak": MessageLookupByLibrary.simpleMessage("Chuỗi thắng"),
    "DailyChallenge": MessageLookupByLibrary.simpleMessage(
      "Thử thách hàng ngày",
    ),
    "DailyChallengeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Thắng câu đố hôm nay ở mức Khó",
    ),
    "DailyCompleted": MessageLookupByLibrary.simpleMessage(
      "Đã hoàn thành hôm nay — chơi lại cho vui",
    ),
    "Difficulty": MessageLookupByLibrary.simpleMessage("Độ khó"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("Dễ"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("Khó"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("Trung bình"),
    "DifficultySuperEasy": MessageLookupByLibrary.simpleMessage("Siêu dễ"),
    "FeedbackBalanced": MessageLookupByLibrary.simpleMessage("Cân bằng"),
    "FeedbackGentle": MessageLookupByLibrary.simpleMessage("Nhẹ"),
    "FeedbackIntensity": MessageLookupByLibrary.simpleMessage(
      "Cường độ phản hồi",
    ),
    "FeedbackLively": MessageLookupByLibrary.simpleMessage("Sống động"),
    "FirstPlayerComputer": MessageLookupByLibrary.simpleMessage("Máy tính"),
    "FirstPlayerHuman": MessageLookupByLibrary.simpleMessage("Người chơi"),
    "FirstPlayerRandom": MessageLookupByLibrary.simpleMessage("Ngẫu nhiên"),
    "GameOver": MessageLookupByLibrary.simpleMessage("Kết thúc"),
    "GameSetup": MessageLookupByLibrary.simpleMessage("Thiết lập ván chơi"),
    "GameStatusAnnouncement": m2,
    "GamesPlayed": MessageLookupByLibrary.simpleMessage("Số ván đã chơi"),
    "GuidedFirstGame": MessageLookupByLibrary.simpleMessage(
      "Học qua ván chơi có hướng dẫn",
    ),
    "GuidedFirstGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tập lật quân, tìm hiểu các ô góc và làm quen theo nhịp của bạn.",
    ),
    "Haptics": MessageLookupByLibrary.simpleMessage("Rung"),
    "Help": MessageLookupByLibrary.simpleMessage("Trợ giúp"),
    "Hint": MessageLookupByLibrary.simpleMessage("Gợi ý"),
    "HintWithAd": MessageLookupByLibrary.simpleMessage(
      "Nước đi hợp lệ · xem quảng cáo",
    ),
    "HintsEnabled": MessageLookupByLibrary.simpleMessage(
      "Đã bật gợi ý cho ván này.",
    ),
    "Home": MessageLookupByLibrary.simpleMessage("Trang chủ"),
    "HomeTagline": MessageLookupByLibrary.simpleMessage(
      "Một chút chiến thuật. Một khoảng riêng cho bạn.",
    ),
    "How_to_play": MessageLookupByLibrary.simpleMessage("Cách chơi?"),
    "How_to_play_explain": MessageLookupByLibrary.simpleMessage(
      "Trong trò chơi, tất cả các quân của đối phương nằm trên một đường thẳng và bị kẹp giữa quân vừa đặt và một quân khác của người chơi hiện tại sẽ được lật sang màu của người chơi hiện tại. Mục tiêu của trò chơi là có nhiều quân mang màu của mình nhất khi ô trống có thể chơi cuối cùng được lấp đầy.",
    ),
    "KeepPlaying": MessageLookupByLibrary.simpleMessage("Chơi tiếp"),
    "More": MessageLookupByLibrary.simpleMessage("Thêm"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("Ứng dụng khác"),
    "NewGame": MessageLookupByLibrary.simpleMessage("Ván mới"),
    "OK": MessageLookupByLibrary.simpleMessage("OK"),
    "Opponent": MessageLookupByLibrary.simpleMessage("Đối thủ"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("Thắng tuyệt đối"),
    "Play": MessageLookupByLibrary.simpleMessage("Chơi"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Chơi cùng bạn bè trên thiết bị này",
    ),
    "PlayerTurn": m3,
    "PrivacyOptions": MessageLookupByLibrary.simpleMessage(
      "Tùy chọn quyền riêng tư",
    ),
    "PrivacyOptionsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Cập nhật lựa chọn quyền riêng tư quảng cáo",
    ),
    "PrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Chính sách quyền riêng tư",
    ),
    "PrivacyPolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "Cách chúng tôi xử lý dữ liệu và quảng cáo",
    ),
    "PurchaseAlreadyOwned": MessageLookupByLibrary.simpleMessage(
      "Bạn đã sở hữu Gỡ quảng cáo.",
    ),
    "PurchaseCancelled": MessageLookupByLibrary.simpleMessage(
      "Đã hủy giao dịch.",
    ),
    "PurchaseFailed": MessageLookupByLibrary.simpleMessage(
      "Giao dịch thất bại. Vui lòng thử lại.",
    ),
    "PurchasePending": MessageLookupByLibrary.simpleMessage(
      "Giao dịch đang chờ phê duyệt…",
    ),
    "PurchaseSuccess": MessageLookupByLibrary.simpleMessage(
      "Đã gỡ quảng cáo. Cảm ơn bạn!",
    ),
    "PurchaseUnavailable": MessageLookupByLibrary.simpleMessage(
      "Hiện không thể mua.",
    ),
    "ReduceMotion": MessageLookupByLibrary.simpleMessage("Giảm chuyển động"),
    "ReduceMotionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Giảm chuyển động quân cờ và hiệu ứng ăn mừng",
    ),
    "Rematch": MessageLookupByLibrary.simpleMessage("Chơi lại"),
    "RemoveAds": MessageLookupByLibrary.simpleMessage("Gỡ quảng cáo"),
    "ReplaceSavedGameMessage": MessageLookupByLibrary.simpleMessage(
      "Ván chưa hoàn tất sẽ bị thay thế. Bạn có thể tiếp tục ván đó từ màn hình chính.",
    ),
    "ReplaceSavedGameTitle": MessageLookupByLibrary.simpleMessage(
      "Bắt đầu ván mới?",
    ),
    "RestartConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "Thế cờ hiện tại sẽ được thay bằng thế cờ ban đầu.",
    ),
    "RestartConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Chơi lại ván này từ đầu?",
    ),
    "RestartGame": MessageLookupByLibrary.simpleMessage("Chơi lại ván này"),
    "RestoreNothing": MessageLookupByLibrary.simpleMessage(
      "Không có giao dịch nào để khôi phục.",
    ),
    "RestorePurchases": MessageLookupByLibrary.simpleMessage(
      "Khôi phục giao dịch",
    ),
    "RestoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Đã khôi phục giao dịch.",
    ),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Bàn cờ xem lại ván chơi",
    ),
    "ReviewCorners": m4,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("Thế cờ cuối cùng"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("Về đầu"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("Xem lại ván chơi"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("Đến cuối"),
    "ReviewMove": m5,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("Nước đi tiếp theo"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("Nước đi trước"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("Thế cờ ban đầu"),
    "Rules": MessageLookupByLibrary.simpleMessage("Luật chơi"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Bàn cờ luôn sẵn sàng khi bạn muốn chơi tiếp.",
    ),
    "Settings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
    "Share": MessageLookupByLibrary.simpleMessage("Chia sẻ"),
    "ShareResult": m6,
    "Sound": MessageLookupByLibrary.simpleMessage("Âm thanh"),
    "StartGame": MessageLookupByLibrary.simpleMessage("Bắt đầu"),
    "StartNewGame": MessageLookupByLibrary.simpleMessage("Bắt đầu ván mới"),
    "Stats": MessageLookupByLibrary.simpleMessage("Thống kê"),
    "Theme": MessageLookupByLibrary.simpleMessage("Giao diện"),
    "ThemeClassic": MessageLookupByLibrary.simpleMessage("Cổ điển"),
    "ThemeContrast": MessageLookupByLibrary.simpleMessage("Tương phản"),
    "ThemeNight": MessageLookupByLibrary.simpleMessage("Ban đêm"),
    "Tie": MessageLookupByLibrary.simpleMessage("Hòa"),
    "Ties": MessageLookupByLibrary.simpleMessage("Hòa"),
    "TurnPassed": m7,
    "TutorialBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Bàn cờ luyện tập",
    ),
    "TutorialCaptureBody": MessageLookupByLibrary.simpleMessage(
      "Bạn cầm quân đen. Chạm vào ô được đánh dấu để kẹp một quân trắng giữa hai quân đen.",
    ),
    "TutorialCaptureDoneBody": MessageLookupByLibrary.simpleMessage(
      "Quân trắng bị kẹp sẽ chuyển thành đen. Tiếp theo quân trắng đi, rồi lại đến lượt bạn.",
    ),
    "TutorialCaptureDoneTitle": MessageLookupByLibrary.simpleMessage(
      "Đó là cách lật quân",
    ),
    "TutorialCaptureTitle": MessageLookupByLibrary.simpleMessage(
      "Lật quân đầu tiên",
    ),
    "TutorialCompleteBody": MessageLookupByLibrary.simpleMessage(
      "Bạn thắng khi kết thúc với nhiều quân hơn. Nếu không có nước đi hợp lệ, lượt của bạn sẽ tự động được bỏ qua. Hãy bắt đầu ở mức Dễ và tăng độ khó khi thấy sẵn sàng.",
    ),
    "TutorialCompleteTitle": MessageLookupByLibrary.simpleMessage(
      "Bạn đã sẵn sàng",
    ),
    "TutorialCornersBody": MessageLookupByLibrary.simpleMessage(
      "Thử thế cờ luyện tập này. Chạm vào ô góc A1 được đánh dấu. Quân ở ô góc không thể bị lật.",
    ),
    "TutorialCornersTitle": MessageLookupByLibrary.simpleMessage("Chiếm ô góc"),
    "TutorialNext": MessageLookupByLibrary.simpleMessage("Tiếp tục"),
    "TutorialPlayEasy": MessageLookupByLibrary.simpleMessage(
      "Chơi một ván mức Dễ",
    ),
    "TutorialProgress": m8,
    "TutorialReplyBody": MessageLookupByLibrary.simpleMessage(
      "Quân trắng đã đi. Chạm vào bất kỳ ô được đánh dấu nào để lật quân tiếp.",
    ),
    "TutorialReplyDoneBody": MessageLookupByLibrary.simpleMessage(
      "Bạn đã hoàn thành một lượt chơi. Giờ hãy thử chiếm một ô góc trong thế cờ luyện tập.",
    ),
    "TutorialSkip": MessageLookupByLibrary.simpleMessage("Bỏ qua hướng dẫn"),
    "TutorialTitle": MessageLookupByLibrary.simpleMessage(
      "Học qua trải nghiệm",
    ),
    "TwoPlayersMode": MessageLookupByLibrary.simpleMessage(
      "2 người chơi (chơi lần lượt)",
    ),
    "Undo": MessageLookupByLibrary.simpleMessage("Hoàn tác"),
    "UndoWithAd": MessageLookupByLibrary.simpleMessage(
      "Hoàn tác · xem quảng cáo",
    ),
    "Watch": MessageLookupByLibrary.simpleMessage("Xem"),
    "WatchAd": MessageLookupByLibrary.simpleMessage("Xem quảng cáo"),
    "WatchAdForHint": MessageLookupByLibrary.simpleMessage(
      "Xem quảng cáo ngắn để hiện nước đi hợp lệ.",
    ),
    "WatchAdForUndo": MessageLookupByLibrary.simpleMessage(
      "Xem quảng cáo ngắn để hoàn tác nước đi.",
    ),
    "White": MessageLookupByLibrary.simpleMessage("trắng"),
    "WhiteWins": MessageLookupByLibrary.simpleMessage("Quân trắng thắng"),
    "WhoGoesFirst": MessageLookupByLibrary.simpleMessage("Ai đi trước?"),
    "WinRate": MessageLookupByLibrary.simpleMessage("Tỷ lệ thắng"),
    "WinsByDifficulty": MessageLookupByLibrary.simpleMessage(
      "Thắng theo độ khó",
    ),
    "WinsLosses": m9,
    "YouColor": m10,
    "YouLose": MessageLookupByLibrary.simpleMessage("Bạn thua"),
    "YouWin": MessageLookupByLibrary.simpleMessage("Bạn thắng!"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("Đến lượt bạn"),
  };
}
