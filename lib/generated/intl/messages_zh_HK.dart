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

  static String m0(coordinate, piece) => "${coordinate}，${piece}";

  static String m1(color) => "電腦 · ${color}";

  static String m2(status, black, white) =>
      "${status}。黑棋 ${black}，白棋 ${white}。";

  static String m3(color) => "輪到${color}落子";

  static String m4(black, white) => "角位 · 黑棋 ${black} · 白棋 ${white}";

  static String m5(move, total) => "第 ${move} 步，共 ${total} 步";

  static String m6(result, black, white, mode) =>
      "${result} · 黑 ${black} – 白 ${white}（${mode}）— 經典黑白棋";

  static String m7(passed, current) => "${passed}無合法落子點，${current}再走一步。";

  static String m8(step, total) => "第 ${step} 課，共 ${total} 課";

  static String m9(wins, losses) => "勝 ${wins} · 負 ${losses}";

  static String m10(color) => "你 · ${color}";

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
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage("成就解鎖"),
    "Achievements": MessageLookupByLibrary.simpleMessage("成就"),
    "AdFailed": MessageLookupByLibrary.simpleMessage("廣告暫不可用，請稍後再試。"),
    "AdLoading": MessageLookupByLibrary.simpleMessage("廣告載入中…"),
    "AdsRemoved": MessageLookupByLibrary.simpleMessage("已移除廣告"),
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("電腦"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("最高連勝"),
    "Black": MessageLookupByLibrary.simpleMessage("黑棋"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("黑棋獲勝"),
    "BoardCell": m0,
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
    "ComputerColor": m1,
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
    "GameStatusAnnouncement": m2,
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
    "Mint_Translate": MessageLookupByLibrary.simpleMessage("薄荷翻譯"),
    "Money_Tracker": MessageLookupByLibrary.simpleMessage("極簡記賬"),
    "More": MessageLookupByLibrary.simpleMessage("更多"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("更多App"),
    "NewGame": MessageLookupByLibrary.simpleMessage("新遊戲"),
    "Novels_Hub": MessageLookupByLibrary.simpleMessage("英文小說站"),
    "OK": MessageLookupByLibrary.simpleMessage("好的"),
    "Opponent": MessageLookupByLibrary.simpleMessage("對手"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("完勝"),
    "Play": MessageLookupByLibrary.simpleMessage("開始遊戲"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage("與好友在本裝置上對戰"),
    "PlayerTurn": m3,
    "PrivacyOptions": MessageLookupByLibrary.simpleMessage("私隱選項"),
    "PrivacyOptionsSubtitle": MessageLookupByLibrary.simpleMessage(
      "更新你的廣告私隱選擇",
    ),
    "PrivacyPolicy": MessageLookupByLibrary.simpleMessage("私隱政策"),
    "PrivacyPolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "了解我們如何處理資料與廣告",
    ),
    "PurchaseAlreadyOwned": MessageLookupByLibrary.simpleMessage("你已擁有移除廣告。"),
    "PurchaseCancelled": MessageLookupByLibrary.simpleMessage("已取消購買。"),
    "PurchaseFailed": MessageLookupByLibrary.simpleMessage("購買失敗，請再試一次。"),
    "PurchasePending": MessageLookupByLibrary.simpleMessage("購買待核准…"),
    "PurchaseSuccess": MessageLookupByLibrary.simpleMessage("已移除廣告，謝謝！"),
    "PurchaseUnavailable": MessageLookupByLibrary.simpleMessage("目前無法購買。"),
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
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage("重溫對局棋盤"),
    "ReviewCorners": m4,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("最終局面"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("回到開局"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("重溫對局"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("前往終局"),
    "ReviewMove": m5,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("下一步"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("上一步"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("初始局面"),
    "Rules": MessageLookupByLibrary.simpleMessage("規則"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "棋盤已為你保留，隨時可以繼續。",
    ),
    "Saving_Ambulance": MessageLookupByLibrary.simpleMessage("拯救救護車"),
    "Settings": MessageLookupByLibrary.simpleMessage("設定"),
    "Share": MessageLookupByLibrary.simpleMessage("分享"),
    "ShareResult": m6,
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
    "TurnPassed": m7,
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
    "TutorialProgress": m8,
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
    "WinsLosses": m9,
    "World_Weather_Live": MessageLookupByLibrary.simpleMessage("極簡天氣"),
    "Yes_Habit": MessageLookupByLibrary.simpleMessage("簽簽習慣"),
    "YouColor": m10,
    "YouLose": MessageLookupByLibrary.simpleMessage("你輸了"),
    "YouWin": MessageLookupByLibrary.simpleMessage("你贏了！"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("輪到你了"),
    "falling_block_puzzle": MessageLookupByLibrary.simpleMessage("經典俄羅斯掌機方塊"),
  };
}
