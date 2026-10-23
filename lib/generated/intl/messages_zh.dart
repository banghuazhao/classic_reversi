// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(coordinate, piece) => "${coordinate}，${piece}";

  static String m1(color) => "电脑 · ${color}";

  static String m2(status, black, white) =>
      "${status}。黑棋 ${black}，白棋 ${white}。";

  static String m3(color) => "轮到${color}落子";

  static String m4(black, white) => "角位 · 黑棋 ${black} · 白棋 ${white}";

  static String m5(move, total) => "第 ${move} 步，共 ${total} 步";

  static String m6(result, black, white, mode) =>
      "${result} · 黑 ${black} – 白 ${white}（${mode}）— 经典黑白棋";

  static String m7(passed, current) => "${passed}无合法落子点，${current}再走一步。";

  static String m8(step, total) => "第 ${step} 课，共 ${total} 课";

  static String m9(wins, losses) => "胜 ${wins} · 负 ${losses}";

  static String m10(color) => "你 · ${color}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Accessibility": MessageLookupByLibrary.simpleMessage("辅助功能"),
    "AchDailyChallenge": MessageLookupByLibrary.simpleMessage("每日冠军"),
    "AchFirstWin": MessageLookupByLibrary.simpleMessage("首胜"),
    "AchGames10": MessageLookupByLibrary.simpleMessage("完成 10 局"),
    "AchGames50": MessageLookupByLibrary.simpleMessage("完成 50 局"),
    "AchPerfectGame": MessageLookupByLibrary.simpleMessage("完美对局"),
    "AchWinHard": MessageLookupByLibrary.simpleMessage("困难模式胜利"),
    "AchWinStreak3": MessageLookupByLibrary.simpleMessage("三连胜"),
    "AchWinStreak5": MessageLookupByLibrary.simpleMessage("五连胜"),
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage("成就解锁"),
    "Achievements": MessageLookupByLibrary.simpleMessage("成就"),
    "AdFailed": MessageLookupByLibrary.simpleMessage("广告暂不可用，请稍后再试。"),
    "AdLoading": MessageLookupByLibrary.simpleMessage("广告加载中…"),
    "AdsRemoved": MessageLookupByLibrary.simpleMessage("广告已去除"),
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("电脑"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("最高连胜"),
    "Black": MessageLookupByLibrary.simpleMessage("黑棋"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("黑棋获胜"),
    "BoardCell": m0,
    "BoardEmpty": MessageLookupByLibrary.simpleMessage("空格"),
    "BoardKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "使用方向键浏览棋盘，按回车键或空格键在标记的格子落子。",
    ),
    "BoardLastMove": MessageLookupByLibrary.simpleMessage("上一步落子"),
    "BoardLegalMove": MessageLookupByLibrary.simpleMessage("合法落子点"),
    "BoardReviewKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "使用方向键浏览棋盘。",
    ),
    "Cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "Classic_15_Puzzle": MessageLookupByLibrary.simpleMessage("十五数字华容道"),
    "Classic_2048": MessageLookupByLibrary.simpleMessage("经典2048"),
    "Classic_Memory_Game": MessageLookupByLibrary.simpleMessage("经典记忆游戏"),
    "Classic_Minesweeper": MessageLookupByLibrary.simpleMessage("经典扫雷"),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage("经典黑白棋"),
    "Classical_Music_Box": MessageLookupByLibrary.simpleMessage("古典音乐盒"),
    "ComputerColor": m1,
    "ComputerThinking": MessageLookupByLibrary.simpleMessage("电脑思考中…"),
    "ContinueGame": MessageLookupByLibrary.simpleMessage("继续游戏"),
    "Crazy_Pyramid": MessageLookupByLibrary.simpleMessage("疯狂金字塔"),
    "CurrentStreak": MessageLookupByLibrary.simpleMessage("连胜"),
    "Cute_Animal_Merge": MessageLookupByLibrary.simpleMessage("合成独角兽"),
    "DailyChallenge": MessageLookupByLibrary.simpleMessage("每日挑战"),
    "DailyChallengeSubtitle": MessageLookupByLibrary.simpleMessage(
      "在困难难度通关今日谜题",
    ),
    "DailyCompleted": MessageLookupByLibrary.simpleMessage("今日已完成 — 可再玩娱乐"),
    "Difficulty": MessageLookupByLibrary.simpleMessage("难度"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("简单"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("困难"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("中等"),
    "DifficultySuperEasy": MessageLookupByLibrary.simpleMessage("超简单"),
    "FeedbackBalanced": MessageLookupByLibrary.simpleMessage("均衡"),
    "FeedbackGentle": MessageLookupByLibrary.simpleMessage("柔和"),
    "FeedbackIntensity": MessageLookupByLibrary.simpleMessage("反馈强度"),
    "FeedbackLively": MessageLookupByLibrary.simpleMessage("活跃"),
    "FirstPlayerComputer": MessageLookupByLibrary.simpleMessage("电脑"),
    "FirstPlayerHuman": MessageLookupByLibrary.simpleMessage("玩家"),
    "FirstPlayerRandom": MessageLookupByLibrary.simpleMessage("随机"),
    "Flappy_Fish": MessageLookupByLibrary.simpleMessage("飞扬的小鱼"),
    "Fling_Knife": MessageLookupByLibrary.simpleMessage("西瓜飞刀"),
    "GameOver": MessageLookupByLibrary.simpleMessage("游戏结束"),
    "GameSetup": MessageLookupByLibrary.simpleMessage("设置对局"),
    "GameStatusAnnouncement": m2,
    "GamesPlayed": MessageLookupByLibrary.simpleMessage("对局数"),
    "Garden_Catch_Bugs": MessageLookupByLibrary.simpleMessage("抓虫子"),
    "GuidedFirstGame": MessageLookupByLibrary.simpleMessage("跟着引导学下棋"),
    "GuidedFirstGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "练习翻子，了解角位，找到自己的节奏。",
    ),
    "Haptics": MessageLookupByLibrary.simpleMessage("触感反馈"),
    "Help": MessageLookupByLibrary.simpleMessage("帮助"),
    "Hint": MessageLookupByLibrary.simpleMessage("提示"),
    "HintWithAd": MessageLookupByLibrary.simpleMessage("合法落子点 · 观看广告"),
    "HintsEnabled": MessageLookupByLibrary.simpleMessage("本局已启用提示。"),
    "Home": MessageLookupByLibrary.simpleMessage("主页"),
    "HomeTagline": MessageLookupByLibrary.simpleMessage("用一点策略，享一刻自在。"),
    "How_to_play": MessageLookupByLibrary.simpleMessage("玩法介绍"),
    "How_to_play_explain": MessageLookupByLibrary.simpleMessage(
      "游戏开局时，棋盘正中央的4格先置放黑白相隔的4枚棋子（亦有求变化相邻放置）。通常黑子先行。双方轮流落子。只要落子和棋盘上任一枚己方的棋子在一条在线（横、直、斜线皆可）夹着对方棋子，就能将对方的这些棋子转变为我己方（翻面即可）。游戏的目标是当最后一个可玩的空方块被填满时，占有大多数棋盘的棋子获胜.",
    ),
    "Image_Guru": MessageLookupByLibrary.simpleMessage("咕噜滤镜"),
    "Instant_Face": MessageLookupByLibrary.simpleMessage("Instant Face"),
    "KeepPlaying": MessageLookupByLibrary.simpleMessage("继续当前对局"),
    "Mint_Translate": MessageLookupByLibrary.simpleMessage("薄荷翻译"),
    "Money_Tracker": MessageLookupByLibrary.simpleMessage("极简记账"),
    "More": MessageLookupByLibrary.simpleMessage("更多"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("更多App"),
    "NewGame": MessageLookupByLibrary.simpleMessage("新游戏"),
    "Novels_Hub": MessageLookupByLibrary.simpleMessage("英文小说站"),
    "OK": MessageLookupByLibrary.simpleMessage("好的"),
    "Opponent": MessageLookupByLibrary.simpleMessage("对手"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("完胜"),
    "Play": MessageLookupByLibrary.simpleMessage("开始游戏"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage("与好友在本设备上对战"),
    "PlayerTurn": m3,
    "PrivacyOptions": MessageLookupByLibrary.simpleMessage("隐私选项"),
    "PrivacyOptionsSubtitle": MessageLookupByLibrary.simpleMessage(
      "更新你的广告隐私选择",
    ),
    "PrivacyPolicy": MessageLookupByLibrary.simpleMessage("隐私政策"),
    "PrivacyPolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "了解我们如何处理数据和广告",
    ),
    "PurchaseAlreadyOwned": MessageLookupByLibrary.simpleMessage("你已拥有去除广告。"),
    "PurchaseCancelled": MessageLookupByLibrary.simpleMessage("已取消购买。"),
    "PurchaseFailed": MessageLookupByLibrary.simpleMessage("购买失败，请重试。"),
    "PurchasePending": MessageLookupByLibrary.simpleMessage("购买待批准…"),
    "PurchaseSuccess": MessageLookupByLibrary.simpleMessage("广告已去除，谢谢！"),
    "PurchaseUnavailable": MessageLookupByLibrary.simpleMessage("暂时无法购买。"),
    "ReduceMotion": MessageLookupByLibrary.simpleMessage("减少动态效果"),
    "ReduceMotionSubtitle": MessageLookupByLibrary.simpleMessage(
      "尽量减少棋子运动和庆祝动画",
    ),
    "Relaxing_Up": MessageLookupByLibrary.simpleMessage("冥想Up"),
    "Rematch": MessageLookupByLibrary.simpleMessage("再来一局"),
    "RemoveAds": MessageLookupByLibrary.simpleMessage("去除广告"),
    "ReplaceSavedGameMessage": MessageLookupByLibrary.simpleMessage(
      "尚未结束的对局将被替换。你也可以返回主页继续这局游戏。",
    ),
    "ReplaceSavedGameTitle": MessageLookupByLibrary.simpleMessage("开始新游戏？"),
    "RestartConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "当前棋盘将恢复为初始局面。",
    ),
    "RestartConfirmTitle": MessageLookupByLibrary.simpleMessage("重新开始这局游戏？"),
    "RestartGame": MessageLookupByLibrary.simpleMessage("重新开始本局"),
    "RestoreNothing": MessageLookupByLibrary.simpleMessage("没有可恢复的购买。"),
    "RestorePurchases": MessageLookupByLibrary.simpleMessage("恢复购买"),
    "RestoreSuccess": MessageLookupByLibrary.simpleMessage("已恢复购买。"),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage("复盘棋盘"),
    "ReviewCorners": m4,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("最终局面"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("回到开局"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("复盘"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("前往终局"),
    "ReviewMove": m5,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("下一步"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("上一步"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("初始局面"),
    "Rules": MessageLookupByLibrary.simpleMessage("规则"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "棋盘已为你保留，随时可以继续。",
    ),
    "Saving_Ambulance": MessageLookupByLibrary.simpleMessage("拯救救护车"),
    "Settings": MessageLookupByLibrary.simpleMessage("设置"),
    "Share": MessageLookupByLibrary.simpleMessage("分享"),
    "ShareResult": m6,
    "Simple_Calculator": MessageLookupByLibrary.simpleMessage("极简计算器"),
    "Solitaire_Guru": MessageLookupByLibrary.simpleMessage("纸牌大师"),
    "Sound": MessageLookupByLibrary.simpleMessage("音效"),
    "Space_Jumper": MessageLookupByLibrary.simpleMessage("你喜欢的跳跳乐"),
    "StartGame": MessageLookupByLibrary.simpleMessage("开始游戏"),
    "StartNewGame": MessageLookupByLibrary.simpleMessage("开始新游戏"),
    "Stats": MessageLookupByLibrary.simpleMessage("战绩"),
    "Sudoku_Lover": MessageLookupByLibrary.simpleMessage("数独迷"),
    "Theme": MessageLookupByLibrary.simpleMessage("主题"),
    "ThemeClassic": MessageLookupByLibrary.simpleMessage("经典"),
    "ThemeContrast": MessageLookupByLibrary.simpleMessage("高对比"),
    "ThemeNight": MessageLookupByLibrary.simpleMessage("夜间"),
    "Tie": MessageLookupByLibrary.simpleMessage("平局"),
    "Ties": MessageLookupByLibrary.simpleMessage("平局"),
    "TurnPassed": m7,
    "TutorialBoardLabel": MessageLookupByLibrary.simpleMessage("练习棋盘"),
    "TutorialCaptureBody": MessageLookupByLibrary.simpleMessage(
      "你执黑棋。点击标记的格子，用两枚黑子夹住一枚白子。",
    ),
    "TutorialCaptureDoneBody": MessageLookupByLibrary.simpleMessage(
      "被夹住的白子变成了黑子。接着轮到白棋，然后又是你的回合。",
    ),
    "TutorialCaptureDoneTitle": MessageLookupByLibrary.simpleMessage("这就是翻子"),
    "TutorialCaptureTitle": MessageLookupByLibrary.simpleMessage("第一次翻子"),
    "TutorialCompleteBody": MessageLookupByLibrary.simpleMessage(
      "结束时棋子更多的一方获胜。没有合法落子点时，会自动跳过回合。先从简单难度开始，熟悉后再挑战更高难度。",
    ),
    "TutorialCompleteTitle": MessageLookupByLibrary.simpleMessage("准备就绪"),
    "TutorialCornersBody": MessageLookupByLibrary.simpleMessage(
      "试试这个练习局面。点击 A1 处标记的角位。角位上的棋子不会被翻转。",
    ),
    "TutorialCornersTitle": MessageLookupByLibrary.simpleMessage("占据角位"),
    "TutorialNext": MessageLookupByLibrary.simpleMessage("继续"),
    "TutorialPlayEasy": MessageLookupByLibrary.simpleMessage("开始简单对局"),
    "TutorialProgress": m8,
    "TutorialReplyBody": MessageLookupByLibrary.simpleMessage(
      "白棋已落子。点击任意标记的格子，再翻一次棋子。",
    ),
    "TutorialReplyDoneBody": MessageLookupByLibrary.simpleMessage(
      "你已完成一轮落子。现在换到练习局面，试着占据角位。",
    ),
    "TutorialSkip": MessageLookupByLibrary.simpleMessage("跳过教学"),
    "TutorialTitle": MessageLookupByLibrary.simpleMessage("边玩边学"),
    "TwoPlayersMode": MessageLookupByLibrary.simpleMessage("双人对战（同机轮流）"),
    "Undo": MessageLookupByLibrary.simpleMessage("悔棋"),
    "UndoWithAd": MessageLookupByLibrary.simpleMessage("悔棋 · 观看广告"),
    "Watch": MessageLookupByLibrary.simpleMessage("观看"),
    "WatchAd": MessageLookupByLibrary.simpleMessage("观看广告"),
    "WatchAdForHint": MessageLookupByLibrary.simpleMessage("观看短广告以显示本局合法落子点。"),
    "WatchAdForUndo": MessageLookupByLibrary.simpleMessage("观看短广告以撤销上一步。"),
    "We_Play_Piano": MessageLookupByLibrary.simpleMessage("弹钢琴"),
    "White": MessageLookupByLibrary.simpleMessage("白棋"),
    "WhiteWins": MessageLookupByLibrary.simpleMessage("白棋获胜"),
    "WhoGoesFirst": MessageLookupByLibrary.simpleMessage("谁先手？"),
    "WinRate": MessageLookupByLibrary.simpleMessage("胜率"),
    "WinsByDifficulty": MessageLookupByLibrary.simpleMessage("各难度胜场"),
    "WinsLosses": m9,
    "World_Weather_Live": MessageLookupByLibrary.simpleMessage("极简天气"),
    "Yes_Habit": MessageLookupByLibrary.simpleMessage("签签习惯"),
    "YouColor": m10,
    "YouLose": MessageLookupByLibrary.simpleMessage("你输了"),
    "YouWin": MessageLookupByLibrary.simpleMessage("你赢了！"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("轮到你了"),
    "falling_block_puzzle": MessageLookupByLibrary.simpleMessage("经典俄罗斯掌机方块"),
  };
}
