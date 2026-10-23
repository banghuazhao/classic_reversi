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

  static String m0(current, target) => "Số ván: ${current} trên ${target}";

  static String m1(current, target) =>
      "Thắng liên tiếp: ${current} trên ${target}";

  static String m2(current, target) =>
      "Số trận thắng: ${current} trên ${target}";

  static String m3(coordinate, piece) => "${coordinate}, ${piece}";

  static String m4(actual, suggested) => "Đã đi ${actual} · Thử ${suggested}";

  static String m5(player) => "Gợi ý cho quân ${player}";

  static String m6(coordinate) =>
      "Bạn đã đi ${coordinate}. Hãy xem lại ý tưởng đằng sau nước đi này.";

  static String m7(count) => "Số nước đáp trả hợp lệ của đối thủ: ${count}.";

  static String m8(coordinate) => "Nước đi gợi ý: ${coordinate}";

  static String m9(color) => "Máy tính · ${color}";

  static String m10(status, black, white) =>
      "${status}. Đen ${black}, trắng ${white}.";

  static String m11(color) => "Lượt quân ${color}";

  static String m12(count) => "Số quân đã lật: ${count}";

  static String m13(coordinate) => "Bạn đã đi ${coordinate}";

  static String m14(color, coordinate) =>
      "Cầm quân ${color}. Chiếm ô góc ${coordinate} trong một nước đi.";

  static String m15(color) =>
      "Cầm quân ${color}. Thắng thế cờ tàn cuộc này trước những nước đáp trả tốt nhất.";

  static String m16(number) => "Gợi ý ${number} trên 3";

  static String m17(coordinate) => "Thử ${coordinate}.";

  static String m18(number) => "Bài tập ${number}";

  static String m19(color) =>
      "Cầm quân ${color}. Buộc đối thủ bỏ lượt để bạn được đi tiếp mà không kết thúc ván chơi.";

  static String m20(completed, total) => "Đã giải ${completed} trên ${total}";

  static String m21(result, score, mode, date) =>
      "${result}. ${score}. ${mode}. ${date}.";

  static String m22(black, white) => "Ô góc · Đen ${black} · Trắng ${white}";

  static String m23(move, total) => "Nước đi ${move} trên ${total}";

  static String m24(black, white) => "Đen ${black} · Trắng ${white}";

  static String m25(result, black, white, mode) =>
      "${result} · Đen ${black} – Trắng ${white} (${mode}) — Classic Reversi";

  static String m26(passed, current) =>
      "Quân ${passed} không có nước đi hợp lệ. Quân ${current} được đi tiếp.";

  static String m27(step, total) => "Bài học ${step} trên ${total}";

  static String m28(wins, losses) => "Thắng ${wins} · Thua ${losses}";

  static String m29(color) => "Bạn · ${color}";

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
    "AchievementGamesProgress": m0,
    "AchievementStreakProgress": m1,
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage(
      "Đã mở thành tựu",
    ),
    "AchievementWinsProgress": m2,
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
    "BoardCell": m3,
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
    "CoachAllowsCorner": MessageLookupByLibrary.simpleMessage(
      "Đối thủ có thể chiếm một ô góc ở lượt tiếp theo.",
    ),
    "CoachAnalyzing": MessageLookupByLibrary.simpleMessage(
      "Đang tìm một thế cờ hữu ích để tìm hiểu…",
    ),
    "CoachAvoidCorner": MessageLookupByLibrary.simpleMessage(
      "Một nước đi hợp lệ khác sẽ cho đối thủ chiếm góc ngay. Nước này tránh được nguy cơ đó.",
    ),
    "CoachComparison": m4,
    "CoachCorner": MessageLookupByLibrary.simpleMessage(
      "Nước này chiếm một ô góc. Quân ở ô góc không thể bị lật.",
    ),
    "CoachEndsGame": MessageLookupByLibrary.simpleMessage(
      "Sau nước này, cả hai bên đều không còn nước đi. Ván chơi kết thúc.",
    ),
    "CoachForPlayer": m5,
    "CoachJump": MessageLookupByLibrary.simpleMessage("Đến thế cờ này"),
    "CoachMatched": m6,
    "CoachNoPosition": MessageLookupByLibrary.simpleMessage(
      "Ván này không có thế cờ nào còn nước đi để thử.",
    ),
    "CoachPass": MessageLookupByLibrary.simpleMessage(
      "Đối thủ không có nước đáp trả hợp lệ nên bạn được đi tiếp.",
    ),
    "CoachPositionTitle": MessageLookupByLibrary.simpleMessage(
      "Tìm hiểu thế cờ này",
    ),
    "CoachPractice": MessageLookupByLibrary.simpleMessage("Thử thế cờ này"),
    "CoachReplies": m7,
    "CoachScope": MessageLookupByLibrary.simpleMessage(
      "Phân tích ngắn giúp gợi ý hướng thử, không đảm bảo đó là nước đi mạnh nhất.",
    ),
    "CoachShareResult": MessageLookupByLibrary.simpleMessage("Chia sẻ kết quả"),
    "CoachSuggested": m8,
    "CoachTitle": MessageLookupByLibrary.simpleMessage(
      "Huấn luyện chiến thuật",
    ),
    "CoachTurnTitle": MessageLookupByLibrary.simpleMessage(
      "Một thế cờ đáng xem lại",
    ),
    "CoachUnavailable": MessageLookupByLibrary.simpleMessage(
      "Hiện chưa thể dùng tính năng huấn luyện. Bạn vẫn có thể xem lại từng nước đi.",
    ),
    "ComputerColor": m9,
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
    "Delete": MessageLookupByLibrary.simpleMessage("Xóa"),
    "DeleteSavedMatch": MessageLookupByLibrary.simpleMessage("Xóa ván chơi"),
    "DeleteSavedMatchMessage": MessageLookupByLibrary.simpleMessage(
      "Bản phát lại này sẽ bị xóa khỏi thư viện. Số liệu thống kê của bạn vẫn được giữ nguyên.",
    ),
    "DeleteSavedMatchTitle": MessageLookupByLibrary.simpleMessage(
      "Xóa ván chơi này?",
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
    "GameStatusAnnouncement": m10,
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
    "MatchLibrary": MessageLookupByLibrary.simpleMessage("Thư viện ván chơi"),
    "MatchLibraryDeleteError": MessageLookupByLibrary.simpleMessage(
      "Không thể xóa ván chơi này. Vui lòng thử lại.",
    ),
    "MatchLibraryEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Hoàn tất một ván chơi để lưu tại đây. Xem lại từng nước đi và tìm ý tưởng cho lần chơi tiếp theo.",
    ),
    "MatchLibraryEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Câu chuyện của bạn bắt đầu từ đây",
    ),
    "MatchLibraryLoadError": MessageLookupByLibrary.simpleMessage(
      "Không thể tải thư viện ván chơi của bạn.",
    ),
    "MatchLibraryOpen": MessageLookupByLibrary.simpleMessage(
      "Xem lại ván chơi",
    ),
    "MatchLibrarySaveError": MessageLookupByLibrary.simpleMessage(
      "Không thể lưu ván này vào thư viện ván chơi.",
    ),
    "MatchLibrarySubtitle": MessageLookupByLibrary.simpleMessage(
      "100 ván hoàn tất gần nhất của bạn, sẵn sàng để xem lại.",
    ),
    "MilestoneCompleted": MessageLookupByLibrary.simpleMessage("Đã hoàn thành"),
    "More": MessageLookupByLibrary.simpleMessage("Thêm"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("Ứng dụng khác"),
    "NewGame": MessageLookupByLibrary.simpleMessage("Ván mới"),
    "NextMilestone": MessageLookupByLibrary.simpleMessage("Cột mốc tiếp theo"),
    "OK": MessageLookupByLibrary.simpleMessage("OK"),
    "Opponent": MessageLookupByLibrary.simpleMessage("Đối thủ"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("Thắng tuyệt đối"),
    "Play": MessageLookupByLibrary.simpleMessage("Chơi"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Chơi cùng bạn bè trên thiết bị này",
    ),
    "PlayerTurn": m11,
    "PracticeBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Bàn cờ luyện chiến thuật",
    ),
    "PracticeFlipped": m12,
    "PracticeInstructions": MessageLookupByLibrary.simpleMessage(
      "Đặt quân vào bất kỳ ô được đánh dấu nào và xem điều gì thay đổi.",
    ),
    "PracticeNoMoves": MessageLookupByLibrary.simpleMessage(
      "Bên này không có nước đi hợp lệ trong thế cờ hiện tại.",
    ),
    "PracticePlayed": m13,
    "PracticeReset": MessageLookupByLibrary.simpleMessage("Thử nước đi khác"),
    "PracticeSafe": MessageLookupByLibrary.simpleMessage(
      "Phần luyện tập không ảnh hưởng đến ván đã lưu hay số liệu thống kê.",
    ),
    "PracticeTitle": MessageLookupByLibrary.simpleMessage("Thử thế cờ này"),
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
    "PurchaseBenefitAds": MessageLookupByLibrary.simpleMessage(
      "Không có quảng cáo biểu ngữ hay quảng cáo khi mở ứng dụng.",
    ),
    "PurchaseBenefitHints": MessageLookupByLibrary.simpleMessage(
      "Gợi ý nước đi hợp lệ ở mọi mức độ khó khi đấu với máy, không cần xem quảng cáo.",
    ),
    "PurchaseBenefitOnce": MessageLookupByLibrary.simpleMessage(
      "Thanh toán một lần. Không thuê bao. Khôi phục bằng tài khoản App Store của bạn.",
    ),
    "PurchaseBenefitUndo": MessageLookupByLibrary.simpleMessage(
      "Hoàn tác một lần mỗi lượt ở mức Khó mà không cần xem quảng cáo.",
    ),
    "PurchaseBenefits": MessageLookupByLibrary.simpleMessage(
      "Mua một lần để gỡ quảng cáo biểu ngữ và quảng cáo khi mở ứng dụng, đồng thời mở khóa hoàn tác ở mức Khó và gợi ý nước đi hợp lệ mà không cần xem quảng cáo thưởng. Có thể khôi phục trên các thiết bị dùng cùng tài khoản App Store.",
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
    "PuzzleAllComplete": MessageLookupByLibrary.simpleMessage(
      "Đã giải cả chín bài tập. Hãy thử lại bất kỳ thế cờ nào để rèn thêm kỹ năng.",
    ),
    "PuzzleBackToArchive": MessageLookupByLibrary.simpleMessage(
      "Về danh sách bài tập",
    ),
    "PuzzleBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Bàn cờ bài tập thực hành",
    ),
    "PuzzleCompleted": MessageLookupByLibrary.simpleMessage("Đã giải"),
    "PuzzleCompletionSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Không thể lưu tiến độ. Hãy giữ màn hình này mở và thử lại.",
    ),
    "PuzzleCornerDescription": MessageLookupByLibrary.simpleMessage(
      "Tìm ô góc an toàn và hoàn thành đường kẹp quân.",
    ),
    "PuzzleCornerHintOne": MessageLookupByLibrary.simpleMessage(
      "Quân ở ô góc không thể bị lật. Hãy tìm một đường quân có thể kẹp.",
    ),
    "PuzzleCornerHintTwo": MessageLookupByLibrary.simpleMessage(
      "Lần từ ô góc mục tiêu vào trong cho đến khi quân của bạn có thể kẹp quân đối thủ.",
    ),
    "PuzzleCornerObjective": m14,
    "PuzzleCornerSkill": MessageLookupByLibrary.simpleMessage("Chiếm ô góc"),
    "PuzzleCornerSuccess": MessageLookupByLibrary.simpleMessage(
      "Đã chiếm được góc. Quân ở ô góc sẽ là của bạn đến hết ván.",
    ),
    "PuzzleEndgameDescription": MessageLookupByLibrary.simpleMessage(
      "Chơi các nước cuối trước những nước đáp trả tốt nhất.",
    ),
    "PuzzleEndgameHintOne": MessageLookupByLibrary.simpleMessage(
      "Số quân cuối cùng quyết định người thắng. Hãy tính đến hết ván.",
    ),
    "PuzzleEndgameHintTwo": MessageLookupByLibrary.simpleMessage(
      "So sánh các nước đáp trả của đối thủ. Lật ít quân hơn có thể giúp bạn giữ nước đi cuối.",
    ),
    "PuzzleEndgameObjective": m15,
    "PuzzleEndgameSkill": MessageLookupByLibrary.simpleMessage(
      "Kết thúc bằng chiến thắng",
    ),
    "PuzzleEndgameSuccess": MessageLookupByLibrary.simpleMessage(
      "Đã thắng tàn cuộc. Lựa chọn của bạn đứng vững trước những nước đáp trả tốt nhất.",
    ),
    "PuzzleEndgameTryAgain": MessageLookupByLibrary.simpleMessage(
      "Cách đi này không thể đảm bảo chiến thắng nếu đối thủ chơi tối ưu. Hãy bắt đầu lại và so sánh nước khác.",
    ),
    "PuzzleHint": m16,
    "PuzzleHintCoordinate": m17,
    "PuzzleNext": MessageLookupByLibrary.simpleMessage("Bài tập tiếp theo"),
    "PuzzleNoResults": MessageLookupByLibrary.simpleMessage(
      "Không có bài tập phù hợp. Hãy thử tìm theo kỹ năng hoặc số bài.",
    ),
    "PuzzleNumber": m18,
    "PuzzleOpponentThinking": MessageLookupByLibrary.simpleMessage(
      "Đang cân nhắc nước đáp trả tốt nhất…",
    ),
    "PuzzlePassDescription": MessageLookupByLibrary.simpleMessage(
      "Khiến đối thủ không còn nước đi hợp lệ.",
    ),
    "PuzzlePassHintOne": MessageLookupByLibrary.simpleMessage(
      "Đối thủ chỉ bỏ lượt khi không còn nước đi hợp lệ.",
    ),
    "PuzzlePassHintTwo": MessageLookupByLibrary.simpleMessage(
      "So sánh các nước đi còn lại của đối thủ sau mỗi nước bạn định đi.",
    ),
    "PuzzlePassObjective": m19,
    "PuzzlePassSkill": MessageLookupByLibrary.simpleMessage(
      "Giành thêm một lượt",
    ),
    "PuzzlePassSuccess": MessageLookupByLibrary.simpleMessage(
      "Bạn đã giành thêm một lượt. Đối thủ không có nước đi hợp lệ và ván chơi tiếp tục.",
    ),
    "PuzzleProgress": m20,
    "PuzzleRestart": MessageLookupByLibrary.simpleMessage("Chơi lại bài tập"),
    "PuzzleRevealHint": MessageLookupByLibrary.simpleMessage("Xem gợi ý"),
    "PuzzleSaveProgress": MessageLookupByLibrary.simpleMessage("Lưu tiến độ"),
    "PuzzleSearch": MessageLookupByLibrary.simpleMessage("Tìm bài tập"),
    "PuzzleTryAgain": MessageLookupByLibrary.simpleMessage(
      "Nước này chưa giải được thế cờ. Hãy bắt đầu lại và thử cách đi khác.",
    ),
    "PuzzleYourMove": MessageLookupByLibrary.simpleMessage("Đến lượt bạn"),
    "Puzzles": MessageLookupByLibrary.simpleMessage("Bài tập thực hành"),
    "PuzzlesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Chín thế cờ được chọn kỹ. Rèn từng kỹ năng một.",
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
    "ResultCardError": MessageLookupByLibrary.simpleMessage(
      "Không thể tạo thẻ kết quả của bạn.",
    ),
    "ResultCardPreparing": MessageLookupByLibrary.simpleMessage(
      "Đang tạo thẻ kết quả…",
    ),
    "ResultCardPreviewLabel": m21,
    "ResultCardShareFailed": MessageLookupByLibrary.simpleMessage(
      "Hiện chưa thể chia sẻ. Vui lòng thử lại.",
    ),
    "ResultCardTitle": MessageLookupByLibrary.simpleMessage("Chia sẻ kết quả"),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Bàn cờ xem lại ván chơi",
    ),
    "ReviewCorners": m22,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("Thế cờ cuối cùng"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("Về đầu"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("Xem lại ván chơi"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("Đến cuối"),
    "ReviewMove": m23,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("Nước đi tiếp theo"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("Nước đi trước"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("Thế cờ ban đầu"),
    "Rules": MessageLookupByLibrary.simpleMessage("Luật chơi"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Bàn cờ luôn sẵn sàng khi bạn muốn chơi tiếp.",
    ),
    "SavedMatchScore": m24,
    "Settings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
    "Share": MessageLookupByLibrary.simpleMessage("Chia sẻ"),
    "ShareResult": m25,
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
    "TryAgain": MessageLookupByLibrary.simpleMessage("Thử lại"),
    "TurnPassed": m26,
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
    "TutorialProgress": m27,
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
    "WinsLosses": m28,
    "YouColor": m29,
    "YouLose": MessageLookupByLibrary.simpleMessage("Bạn thua"),
    "YouWin": MessageLookupByLibrary.simpleMessage("Bạn thắng!"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("Đến lượt bạn"),
  };
}
