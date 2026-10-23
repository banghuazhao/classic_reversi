// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_HK locale. All the
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
  String get localeName => 'zh_HK';

  static String m0(current, target) => "對局：${current}/${target}";

  static String m1(current, target) => "連勝：${current}/${target}";

  static String m2(current, target) => "獲勝：${current}/${target}";

  static String m3(coordinate, piece) => "${coordinate}，${piece}";

  static String m4(actual, suggested) => "實際落子 ${actual} · 嘗試 ${suggested}";

  static String m5(player) => "${player}的落子思路";

  static String m6(coordinate) => "你下在了${coordinate}，不妨回顧這一步的思路。";

  static String m7(count) => "對手的合法應手數量：${count}。";

  static String m8(coordinate) => "建議落子：${coordinate}";

  static String m9(color) => "電腦 · ${color}";

  static String m10(status, black, white) =>
      "${status}。黑棋 ${black}，白棋 ${white}。";

  static String m11(color) => "輪到${color}落子";

  static String m12(count) => "翻轉棋子：${count}";

  static String m13(coordinate) => "你下在了${coordinate}";

  static String m14(color, coordinate) => "執${color}，一步佔據${coordinate}角位。";

  static String m15(color) => "執${color}，應對最佳應手並贏下這個殘局。";

  static String m16(number) => "提示 ${number}/3";

  static String m17(coordinate) => "試試${coordinate}。";

  static String m18(number) => "第 ${number} 題";

  static String m19(color) => "執${color}，在不結束對局的情況下，讓對手跳過回合，自己再走一步。";

  static String m20(completed, total) => "已解開 ${completed}/${total}";

  static String m21(result, score, mode, date) =>
      "${result}。${score}。${mode}。${date}。";

  static String m22(black, white) => "角位 · 黑棋 ${black} · 白棋 ${white}";

  static String m23(move, total) => "第 ${move} 步，共 ${total} 步";

  static String m24(black, white) => "黑棋 ${black} · 白棋 ${white}";

  static String m25(result, black, white, mode) =>
      "${result} · 黑 ${black} – 白 ${white}（${mode}）— 經典黑白棋";

  static String m26(passed, current) => "${passed}無合法落子點，${current}再走一步。";

  static String m27(step, total) => "第 ${step} 課，共 ${total} 課";

  static String m28(wins, losses) => "勝 ${wins} · 負 ${losses}";

  static String m29(color) => "你 · ${color}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Accessibility": MessageLookupByLibrary.simpleMessage("輔助使用"),
    "AchDailyChallenge": MessageLookupByLibrary.simpleMessage("每日冠軍"),
    "AchFirstWin": MessageLookupByLibrary.simpleMessage("首勝"),
    "AchGames10": MessageLookupByLibrary.simpleMessage("完成 10 局"),
    "AchGames50": MessageLookupByLibrary.simpleMessage("完成 50 局"),
    "AchPerfectGame": MessageLookupByLibrary.simpleMessage("完美對局"),
    "AchWinHard": MessageLookupByLibrary.simpleMessage("困難模式勝利"),
    "AchWinStreak3": MessageLookupByLibrary.simpleMessage("三連勝"),
    "AchWinStreak5": MessageLookupByLibrary.simpleMessage("五連勝"),
    "AchievementGamesProgress": m0,
    "AchievementStreakProgress": m1,
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage("成就解鎖"),
    "AchievementWinsProgress": m2,
    "Achievements": MessageLookupByLibrary.simpleMessage("成就"),
    "AdFailed": MessageLookupByLibrary.simpleMessage("廣告暫不可用，請稍後再試。"),
    "AdLoading": MessageLookupByLibrary.simpleMessage("廣告載入中…"),
    "AdsRemoved": MessageLookupByLibrary.simpleMessage("已移除廣告"),
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("電腦"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("最高連勝"),
    "Black": MessageLookupByLibrary.simpleMessage("黑棋"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("黑棋獲勝"),
    "BoardCell": m3,
    "BoardEmpty": MessageLookupByLibrary.simpleMessage("空格"),
    "BoardKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "使用方向鍵瀏覽棋盤，按回車鍵或空白鍵在標示的格子落子。",
    ),
    "BoardLastMove": MessageLookupByLibrary.simpleMessage("上一步落子"),
    "BoardLegalMove": MessageLookupByLibrary.simpleMessage("合法落子點"),
    "BoardReviewKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "使用方向鍵瀏覽棋盤。",
    ),
    "Cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "Classic_2048": MessageLookupByLibrary.simpleMessage("經典2048"),
    "Classic_Memory_Game": MessageLookupByLibrary.simpleMessage("經典記憶遊戲"),
    "Classic_Minesweeper": MessageLookupByLibrary.simpleMessage("經典掃雷"),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage("經典黑白棋"),
    "Classical_Music_Box": MessageLookupByLibrary.simpleMessage("古典音樂盒"),
    "CoachAllowsCorner": MessageLookupByLibrary.simpleMessage("對手可以在下一回合佔據角位。"),
    "CoachAnalyzing": MessageLookupByLibrary.simpleMessage("正在尋找值得研究的局面…"),
    "CoachAvoidCorner": MessageLookupByLibrary.simpleMessage(
      "另一個合法落子會讓對手立即佔角，這一步避開了該威脅。",
    ),
    "CoachComparison": m4,
    "CoachCorner": MessageLookupByLibrary.simpleMessage(
      "這一步可以佔據角位，角位上的棋子不會被翻轉。",
    ),
    "CoachEndsGame": MessageLookupByLibrary.simpleMessage(
      "走完這一步後，雙方都無法落子，對局結束。",
    ),
    "CoachForPlayer": m5,
    "CoachJump": MessageLookupByLibrary.simpleMessage("前往這個局面"),
    "CoachMatched": m6,
    "CoachNoPosition": MessageLookupByLibrary.simpleMessage(
      "這局對局中沒有可供嘗試落子的局面。",
    ),
    "CoachPass": MessageLookupByLibrary.simpleMessage("對手沒有合法應手，因此你可以再走一步。"),
    "CoachPositionTitle": MessageLookupByLibrary.simpleMessage("研究這個局面"),
    "CoachPractice": MessageLookupByLibrary.simpleMessage("試下這個局面"),
    "CoachReplies": m7,
    "CoachScope": MessageLookupByLibrary.simpleMessage(
      "簡短搜尋會提供值得嘗試的思路，但不保證是最強的一步。",
    ),
    "CoachShareResult": MessageLookupByLibrary.simpleMessage("分享戰績"),
    "CoachSuggested": m8,
    "CoachTitle": MessageLookupByLibrary.simpleMessage("策略教練"),
    "CoachTurnTitle": MessageLookupByLibrary.simpleMessage("值得回顧的局面"),
    "CoachUnavailable": MessageLookupByLibrary.simpleMessage(
      "暫時無法使用教練功能，你仍然可以逐步重溫對局。",
    ),
    "ComputerColor": m9,
    "ComputerThinking": MessageLookupByLibrary.simpleMessage("電腦思考中…"),
    "ContinueGame": MessageLookupByLibrary.simpleMessage("繼續遊戲"),
    "Crazy_Pyramid": MessageLookupByLibrary.simpleMessage("瘋狂金字塔"),
    "CurrentStreak": MessageLookupByLibrary.simpleMessage("連勝"),
    "Cute_Animal_Merge": MessageLookupByLibrary.simpleMessage("合成獨角獸"),
    "DailyChallenge": MessageLookupByLibrary.simpleMessage("每日挑戰"),
    "DailyChallengeSubtitle": MessageLookupByLibrary.simpleMessage(
      "在困難難度通關今日謎題",
    ),
    "DailyCompleted": MessageLookupByLibrary.simpleMessage("今日已完成 — 可再玩娛樂"),
    "Delete": MessageLookupByLibrary.simpleMessage("刪除"),
    "DeleteSavedMatch": MessageLookupByLibrary.simpleMessage("刪除對局"),
    "DeleteSavedMatchMessage": MessageLookupByLibrary.simpleMessage(
      "這局對局的重溫紀錄將從收藏中移除，統計數據維持不變。",
    ),
    "DeleteSavedMatchTitle": MessageLookupByLibrary.simpleMessage("刪除這局對局？"),
    "Difficulty": MessageLookupByLibrary.simpleMessage("難度"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("簡單"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("困難"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("中等"),
    "DifficultySuperEasy": MessageLookupByLibrary.simpleMessage("超簡單"),
    "FeedbackBalanced": MessageLookupByLibrary.simpleMessage("均衡"),
    "FeedbackGentle": MessageLookupByLibrary.simpleMessage("柔和"),
    "FeedbackIntensity": MessageLookupByLibrary.simpleMessage("回饋強度"),
    "FeedbackLively": MessageLookupByLibrary.simpleMessage("活躍"),
    "FirstPlayerComputer": MessageLookupByLibrary.simpleMessage("電腦"),
    "FirstPlayerHuman": MessageLookupByLibrary.simpleMessage("玩家"),
    "FirstPlayerRandom": MessageLookupByLibrary.simpleMessage("隨機"),
    "Flappy_Fish": MessageLookupByLibrary.simpleMessage("飛揚的小魚"),
    "Fling_Knife": MessageLookupByLibrary.simpleMessage("西瓜飛刀"),
    "GameOver": MessageLookupByLibrary.simpleMessage("遊戲結束"),
    "GameSetup": MessageLookupByLibrary.simpleMessage("設定對局"),
    "GameStatusAnnouncement": m10,
    "GamesPlayed": MessageLookupByLibrary.simpleMessage("對局數"),
    "Garden_Catch_Bugs": MessageLookupByLibrary.simpleMessage("抓蟲子"),
    "GuidedFirstGame": MessageLookupByLibrary.simpleMessage("跟著引導學下棋"),
    "GuidedFirstGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "練習翻子，了解角位，找到自己的節奏。",
    ),
    "Haptics": MessageLookupByLibrary.simpleMessage("觸感回饋"),
    "Help": MessageLookupByLibrary.simpleMessage("幫助"),
    "Hint": MessageLookupByLibrary.simpleMessage("提示"),
    "HintWithAd": MessageLookupByLibrary.simpleMessage("合法落子點 · 觀看廣告"),
    "HintsEnabled": MessageLookupByLibrary.simpleMessage("本局已啟用提示。"),
    "Home": MessageLookupByLibrary.simpleMessage("主頁"),
    "HomeTagline": MessageLookupByLibrary.simpleMessage("用一點策略，享一刻自在。"),
    "How_to_play": MessageLookupByLibrary.simpleMessage("玩法介紹"),
    "How_to_play_explain": MessageLookupByLibrary.simpleMessage(
      "遊戲開局時，棋盤正中央的4格先置放黑白相隔的4枚棋子（亦有求變化相鄰放置）。通常黑子先行。雙方輪流落子。只要落子和棋盤上任一枚己方的棋子在一條在線（橫、直、斜線皆可）夾著對方棋子，就能將對方的這些棋子轉變為我己方（翻面即可）。遊戲的目標是當最後一個可玩的空方塊被填滿時，佔有大多數棋盤的棋子獲勝.",
    ),
    "Image_Guru": MessageLookupByLibrary.simpleMessage("咕嚕濾鏡"),
    "Instant_Face": MessageLookupByLibrary.simpleMessage("Instant Face"),
    "KeepPlaying": MessageLookupByLibrary.simpleMessage("繼續目前的對局"),
    "MatchLibrary": MessageLookupByLibrary.simpleMessage("對局收藏"),
    "MatchLibraryDeleteError": MessageLookupByLibrary.simpleMessage(
      "無法刪除這局對局，請再試一次。",
    ),
    "MatchLibraryEmptyBody": MessageLookupByLibrary.simpleMessage(
      "完成一局後，對局就會儲存在這裏。回顧每一步，發現下次可以嘗試的新思路。",
    ),
    "MatchLibraryEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "你的棋局故事，從這裏開始",
    ),
    "MatchLibraryLoadError": MessageLookupByLibrary.simpleMessage("無法載入對局收藏。"),
    "MatchLibraryOpen": MessageLookupByLibrary.simpleMessage("重溫對局"),
    "MatchLibrarySaveError": MessageLookupByLibrary.simpleMessage(
      "無法將這局對局儲存到收藏。",
    ),
    "MatchLibrarySubtitle": MessageLookupByLibrary.simpleMessage(
      "保留最近完成的100局，隨時重溫每一步。",
    ),
    "MilestoneCompleted": MessageLookupByLibrary.simpleMessage("已完成"),
    "Mint_Translate": MessageLookupByLibrary.simpleMessage("薄荷翻譯"),
    "Money_Tracker": MessageLookupByLibrary.simpleMessage("極簡記賬"),
    "More": MessageLookupByLibrary.simpleMessage("更多"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("更多App"),
    "NewGame": MessageLookupByLibrary.simpleMessage("新遊戲"),
    "NextMilestone": MessageLookupByLibrary.simpleMessage("下個目標"),
    "Novels_Hub": MessageLookupByLibrary.simpleMessage("英文小說站"),
    "OK": MessageLookupByLibrary.simpleMessage("好的"),
    "Opponent": MessageLookupByLibrary.simpleMessage("對手"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("完勝"),
    "Play": MessageLookupByLibrary.simpleMessage("開始遊戲"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage("與好友在本裝置上對戰"),
    "PlayerTurn": m11,
    "PracticeBoardLabel": MessageLookupByLibrary.simpleMessage("策略練習棋盤"),
    "PracticeFlipped": m12,
    "PracticeInstructions": MessageLookupByLibrary.simpleMessage(
      "在任何標示的格子落子，觀察局面如何變化。",
    ),
    "PracticeNoMoves": MessageLookupByLibrary.simpleMessage(
      "目前局面中，這一方沒有合法落子點。",
    ),
    "PracticePlayed": m13,
    "PracticeReset": MessageLookupByLibrary.simpleMessage("嘗試其他落子"),
    "PracticeSafe": MessageLookupByLibrary.simpleMessage("練習不會影響已儲存的對局和統計數據。"),
    "PracticeTitle": MessageLookupByLibrary.simpleMessage("試下這個局面"),
    "PrivacyOptions": MessageLookupByLibrary.simpleMessage("私隱選項"),
    "PrivacyOptionsSubtitle": MessageLookupByLibrary.simpleMessage(
      "更新你的廣告私隱選擇",
    ),
    "PrivacyPolicy": MessageLookupByLibrary.simpleMessage("私隱政策"),
    "PrivacyPolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "了解我們如何處理資料與廣告",
    ),
    "PurchaseAlreadyOwned": MessageLookupByLibrary.simpleMessage("你已擁有移除廣告。"),
    "PurchaseBenefitAds": MessageLookupByLibrary.simpleMessage(
      "移除橫幅廣告和啟動應用程式時的廣告。",
    ),
    "PurchaseBenefitHints": MessageLookupByLibrary.simpleMessage(
      "所有電腦對戰難度均可顯示合法落子提示，毋須觀看廣告。",
    ),
    "PurchaseBenefitOnce": MessageLookupByLibrary.simpleMessage(
      "一次購買，毋須訂閱。可透過你的 App Store 帳戶還原。",
    ),
    "PurchaseBenefitUndo": MessageLookupByLibrary.simpleMessage(
      "困難難度每回合可悔棋一次，毋須觀看廣告。",
    ),
    "PurchaseBenefits": MessageLookupByLibrary.simpleMessage(
      "一次購買即可移除橫幅廣告和啟動應用程式時的廣告，並解鎖困難難度悔棋與合法落子提示，毋須觀看獎勵廣告。使用同一 App Store 帳戶的裝置均可還原購買。",
    ),
    "PurchaseCancelled": MessageLookupByLibrary.simpleMessage("已取消購買。"),
    "PurchaseFailed": MessageLookupByLibrary.simpleMessage("購買失敗，請再試一次。"),
    "PurchasePending": MessageLookupByLibrary.simpleMessage("購買待核准…"),
    "PurchaseSuccess": MessageLookupByLibrary.simpleMessage("已移除廣告，謝謝！"),
    "PurchaseUnavailable": MessageLookupByLibrary.simpleMessage("目前無法購買。"),
    "PuzzleAllComplete": MessageLookupByLibrary.simpleMessage(
      "九題全部解開！隨時重溫任何局面，繼續磨練棋藝。",
    ),
    "PuzzleBackToArchive": MessageLookupByLibrary.simpleMessage("返回練習列表"),
    "PuzzleBoardLabel": MessageLookupByLibrary.simpleMessage("練習題棋盤"),
    "PuzzleCompleted": MessageLookupByLibrary.simpleMessage("已解開"),
    "PuzzleCompletionSaveFailed": MessageLookupByLibrary.simpleMessage(
      "無法儲存進度，請保持此頁面開啟並再試一次。",
    ),
    "PuzzleCornerDescription": MessageLookupByLibrary.simpleMessage(
      "找到安全的角位，形成夾擊並翻子。",
    ),
    "PuzzleCornerHintOne": MessageLookupByLibrary.simpleMessage(
      "角位上的棋子不會被翻轉，找一條可以形成夾擊的路線。",
    ),
    "PuzzleCornerHintTwo": MessageLookupByLibrary.simpleMessage(
      "從目標角位向內尋找，直到你的棋子能夾住對手棋子。",
    ),
    "PuzzleCornerObjective": m14,
    "PuzzleCornerSkill": MessageLookupByLibrary.simpleMessage("佔據角位"),
    "PuzzleCornerSuccess": MessageLookupByLibrary.simpleMessage(
      "成功佔角！角位棋子將一直屬於你，直到對局結束。",
    ),
    "PuzzleEndgameDescription": MessageLookupByLibrary.simpleMessage(
      "應對最佳應手，走好最後幾步。",
    ),
    "PuzzleEndgameHintOne": MessageLookupByLibrary.simpleMessage(
      "最終棋子數量決定勝負，試著推算到最後。",
    ),
    "PuzzleEndgameHintTwo": MessageLookupByLibrary.simpleMessage(
      "比較對手的應手。少翻一些棋子，可能有助保留最後一步。",
    ),
    "PuzzleEndgameObjective": m15,
    "PuzzleEndgameSkill": MessageLookupByLibrary.simpleMessage("贏下殘局"),
    "PuzzleEndgameSuccess": MessageLookupByLibrary.simpleMessage(
      "成功贏下殘局！你的選擇經受住了最佳應手的考驗。",
    ),
    "PuzzleEndgameTryAgain": MessageLookupByLibrary.simpleMessage(
      "面對最佳應對，這條路線無法確保獲勝。請重新開始，比較其他落子。",
    ),
    "PuzzleHint": m16,
    "PuzzleHintCoordinate": m17,
    "PuzzleNext": MessageLookupByLibrary.simpleMessage("下一題"),
    "PuzzleNoResults": MessageLookupByLibrary.simpleMessage(
      "沒有相符的練習題，請嘗試搜尋技巧或題目編號。",
    ),
    "PuzzleNumber": m18,
    "PuzzleOpponentThinking": MessageLookupByLibrary.simpleMessage("正在考慮最佳應手…"),
    "PuzzlePassDescription": MessageLookupByLibrary.simpleMessage(
      "讓對手沒有合法落子點。",
    ),
    "PuzzlePassHintOne": MessageLookupByLibrary.simpleMessage(
      "只有對手沒有合法落子點時，才會跳過回合。",
    ),
    "PuzzlePassHintTwo": MessageLookupByLibrary.simpleMessage(
      "比較每個候選落子之後，對手還可以走哪些位置。",
    ),
    "PuzzlePassObjective": m19,
    "PuzzlePassSkill": MessageLookupByLibrary.simpleMessage("爭取再走一步"),
    "PuzzlePassSuccess": MessageLookupByLibrary.simpleMessage(
      "你爭取到了下一步！對手沒有合法落子點，對局繼續。",
    ),
    "PuzzleProgress": m20,
    "PuzzleRestart": MessageLookupByLibrary.simpleMessage("重新練習"),
    "PuzzleRevealHint": MessageLookupByLibrary.simpleMessage("查看提示"),
    "PuzzleSaveProgress": MessageLookupByLibrary.simpleMessage("儲存進度"),
    "PuzzleSearch": MessageLookupByLibrary.simpleMessage("搜尋練習題"),
    "PuzzleTryAgain": MessageLookupByLibrary.simpleMessage(
      "這一步尚未達成目標，請重新開始，嘗試其他走法。",
    ),
    "PuzzleYourMove": MessageLookupByLibrary.simpleMessage("輪到你落子"),
    "Puzzles": MessageLookupByLibrary.simpleMessage("棋局練習"),
    "PuzzlesSubtitle": MessageLookupByLibrary.simpleMessage("九個精選局面，每次練好一項技巧。"),
    "ReduceMotion": MessageLookupByLibrary.simpleMessage("減少動態效果"),
    "ReduceMotionSubtitle": MessageLookupByLibrary.simpleMessage(
      "盡量減少棋子移動和慶祝動畫",
    ),
    "Relaxing_Up": MessageLookupByLibrary.simpleMessage("冥想Up"),
    "Rematch": MessageLookupByLibrary.simpleMessage("再來一局"),
    "RemoveAds": MessageLookupByLibrary.simpleMessage("移除廣告"),
    "ReplaceSavedGameMessage": MessageLookupByLibrary.simpleMessage(
      "尚未結束的對局將被取代。你也可以返回主頁繼續這局遊戲。",
    ),
    "ReplaceSavedGameTitle": MessageLookupByLibrary.simpleMessage("開始新遊戲？"),
    "RestartConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "目前的棋盤將回復為初始局面。",
    ),
    "RestartConfirmTitle": MessageLookupByLibrary.simpleMessage("重新開始這局遊戲？"),
    "RestartGame": MessageLookupByLibrary.simpleMessage("重新開始本局"),
    "RestoreNothing": MessageLookupByLibrary.simpleMessage("沒有可恢復的購買。"),
    "RestorePurchases": MessageLookupByLibrary.simpleMessage("恢復購買"),
    "RestoreSuccess": MessageLookupByLibrary.simpleMessage("已恢復購買。"),
    "ResultCardError": MessageLookupByLibrary.simpleMessage("無法製作戰績卡。"),
    "ResultCardPreparing": MessageLookupByLibrary.simpleMessage("正在製作戰績卡…"),
    "ResultCardPreviewLabel": m21,
    "ResultCardShareFailed": MessageLookupByLibrary.simpleMessage(
      "暫時無法分享，請再試一次。",
    ),
    "ResultCardTitle": MessageLookupByLibrary.simpleMessage("分享戰績"),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage("重溫對局棋盤"),
    "ReviewCorners": m22,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("最終局面"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("回到開局"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("重溫對局"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("前往終局"),
    "ReviewMove": m23,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("下一步"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("上一步"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("初始局面"),
    "Rules": MessageLookupByLibrary.simpleMessage("規則"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "棋盤已為你保留，隨時可以繼續。",
    ),
    "SavedMatchScore": m24,
    "Saving_Ambulance": MessageLookupByLibrary.simpleMessage("拯救救護車"),
    "Settings": MessageLookupByLibrary.simpleMessage("設定"),
    "Share": MessageLookupByLibrary.simpleMessage("分享"),
    "ShareResult": m25,
    "Simple_Calculator": MessageLookupByLibrary.simpleMessage("極簡計算器"),
    "Solitaire_Guru": MessageLookupByLibrary.simpleMessage("紙牌大師"),
    "Sound": MessageLookupByLibrary.simpleMessage("音效"),
    "Space_Jumper": MessageLookupByLibrary.simpleMessage("你喜歡的跳跳樂"),
    "StartGame": MessageLookupByLibrary.simpleMessage("開始遊戲"),
    "StartNewGame": MessageLookupByLibrary.simpleMessage("開始新遊戲"),
    "Stats": MessageLookupByLibrary.simpleMessage("戰績"),
    "Sudoku_Lover": MessageLookupByLibrary.simpleMessage("數獨迷"),
    "Theme": MessageLookupByLibrary.simpleMessage("主題"),
    "ThemeClassic": MessageLookupByLibrary.simpleMessage("經典"),
    "ThemeContrast": MessageLookupByLibrary.simpleMessage("高對比"),
    "ThemeNight": MessageLookupByLibrary.simpleMessage("夜間"),
    "Tie": MessageLookupByLibrary.simpleMessage("平局"),
    "Ties": MessageLookupByLibrary.simpleMessage("平局"),
    "TryAgain": MessageLookupByLibrary.simpleMessage("再試一次"),
    "TurnPassed": m26,
    "TutorialBoardLabel": MessageLookupByLibrary.simpleMessage("練習棋盤"),
    "TutorialCaptureBody": MessageLookupByLibrary.simpleMessage(
      "你執黑棋。點按標示的格子，用兩枚黑子夾住一枚白子。",
    ),
    "TutorialCaptureDoneBody": MessageLookupByLibrary.simpleMessage(
      "被夾住的白子變成了黑子。接著輪到白棋，然後又是你的回合。",
    ),
    "TutorialCaptureDoneTitle": MessageLookupByLibrary.simpleMessage("這就是翻子"),
    "TutorialCaptureTitle": MessageLookupByLibrary.simpleMessage("第一次翻子"),
    "TutorialCompleteBody": MessageLookupByLibrary.simpleMessage(
      "結束時棋子較多的一方獲勝。沒有合法落子點時，會自動跳過回合。先從簡單難度開始，熟習後再挑戰更高難度。",
    ),
    "TutorialCompleteTitle": MessageLookupByLibrary.simpleMessage("準備就緒"),
    "TutorialCornersBody": MessageLookupByLibrary.simpleMessage(
      "試試這個練習局面。點按 A1 處標示的角位。角位上的棋子不會被翻轉。",
    ),
    "TutorialCornersTitle": MessageLookupByLibrary.simpleMessage("佔據角位"),
    "TutorialNext": MessageLookupByLibrary.simpleMessage("繼續"),
    "TutorialPlayEasy": MessageLookupByLibrary.simpleMessage("開始簡單對局"),
    "TutorialProgress": m27,
    "TutorialReplyBody": MessageLookupByLibrary.simpleMessage(
      "白棋已落子。點按任何標示的格子，再翻一次棋子。",
    ),
    "TutorialReplyDoneBody": MessageLookupByLibrary.simpleMessage(
      "你已完成一輪落子。現在換到練習局面，試著佔據角位。",
    ),
    "TutorialSkip": MessageLookupByLibrary.simpleMessage("略過教學"),
    "TutorialTitle": MessageLookupByLibrary.simpleMessage("邊玩邊學"),
    "TwoPlayersMode": MessageLookupByLibrary.simpleMessage("雙人對戰（同機輪流）"),
    "Undo": MessageLookupByLibrary.simpleMessage("悔棋"),
    "UndoWithAd": MessageLookupByLibrary.simpleMessage("悔棋 · 觀看廣告"),
    "Watch": MessageLookupByLibrary.simpleMessage("觀看"),
    "WatchAd": MessageLookupByLibrary.simpleMessage("觀看廣告"),
    "WatchAdForHint": MessageLookupByLibrary.simpleMessage("觀看短廣告以顯示本局合法落子點。"),
    "WatchAdForUndo": MessageLookupByLibrary.simpleMessage("觀看短廣告以撤銷上一步。"),
    "We_Play_Piano": MessageLookupByLibrary.simpleMessage("彈鋼琴"),
    "White": MessageLookupByLibrary.simpleMessage("白棋"),
    "WhiteWins": MessageLookupByLibrary.simpleMessage("白棋獲勝"),
    "WhoGoesFirst": MessageLookupByLibrary.simpleMessage("誰先手？"),
    "WinRate": MessageLookupByLibrary.simpleMessage("勝率"),
    "WinsByDifficulty": MessageLookupByLibrary.simpleMessage("各難度勝場"),
    "WinsLosses": m28,
    "World_Weather_Live": MessageLookupByLibrary.simpleMessage("極簡天氣"),
    "Yes_Habit": MessageLookupByLibrary.simpleMessage("簽簽習慣"),
    "YouColor": m29,
    "YouLose": MessageLookupByLibrary.simpleMessage("你輸了"),
    "YouWin": MessageLookupByLibrary.simpleMessage("你贏了！"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("輪到你了"),
    "falling_block_puzzle": MessageLookupByLibrary.simpleMessage("經典俄羅斯掌機方塊"),
  };
}
