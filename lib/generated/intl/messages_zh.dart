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

  static String m0(current, target) => "对局：${current}/${target}";

  static String m1(current, target) => "连胜：${current}/${target}";

  static String m2(current, target) => "获胜：${current}/${target}";

  static String m3(best, good, inaccuracies, mistakes) =>
      "最佳 ${best} · 良好 ${good} · 不精确 ${inaccuracies} · 失误 ${mistakes}";

  static String m4(move, played, suggested) =>
      "第 ${move} 步：下了 ${played}，${suggested} 更好";

  static String m5(coordinate, piece) => "${coordinate}，${piece}";

  static String m6(actual, suggested) => "实际落子 ${actual} · 尝试 ${suggested}";

  static String m7(player) => "${player}的落子思路";

  static String m8(coordinate) => "你下在了${coordinate}，不妨回顾这一步的思路。";

  static String m9(count) => "对手的合法应手数量：${count}。";

  static String m10(coordinate) => "建议落子：${coordinate}";

  static String m11(count) =>
      "你今天已用完 ${count} 次免费教练提示。观看一段短广告可再获得一次提示，或升级高级版享受无限提示。";

  static String m12(count) => "你今天已用完 ${count} 次免费教练提示。升级高级版即可无限使用，或明天再来。";

  static String m13(coordinate) => "教练提示：试试 ${coordinate}。";

  static String m14(count) => "教练提示 · 今日免费 ${count} 次";

  static String m15(color) => "电脑 · ${color}";

  static String m16(status, black, white) =>
      "${status}。黑棋 ${black}，白棋 ${white}。";

  static String m17(price) => "获取高级版 · ${price}";

  static String m18(color) => "轮到${color}落子";

  static String m19(count) => "翻转棋子：${count}";

  static String m20(coordinate) => "你下在了${coordinate}";

  static String m21(store) => "一次付费，无需订阅。可随时用你的 ${store} 账户恢复购买。";

  static String m22(theme) => "${theme} · 高级版";

  static String m23(count) => "随时查看好棋及原因。免费玩家每天可用 ${count} 次。";

  static String m24(color, coordinate) => "执${color}，一步占据${coordinate}角位。";

  static String m25(color) => "执${color}，应对最佳应手并赢下这个残局。";

  static String m26(number) => "提示 ${number}/3";

  static String m27(coordinate) => "试试${coordinate}。";

  static String m28(number) => "第 ${number} 题";

  static String m29(color) => "执${color}，在不结束对局的情况下，让对手跳过回合，自己再走一步。";

  static String m30(completed, total) => "已解开 ${completed}/${total}";

  static String m31(store) => "已购买？可从你的 ${store} 账户恢复。";

  static String m32(result, score, mode, date) =>
      "${result}。${score}。${mode}。${date}。";

  static String m33(black, white) => "角位 · 黑棋 ${black} · 白棋 ${white}";

  static String m34(move, total) => "第 ${move} 步，共 ${total} 步";

  static String m35(black, white) => "黑棋 ${black} · 白棋 ${white}";

  static String m36(result, black, white, mode) =>
      "${result} · 黑 ${black} – 白 ${white}（${mode}）— 经典黑白棋";

  static String m37(passed, current) => "${passed}无合法落子点，${current}再走一步。";

  static String m38(step, total) => "第 ${step} 课，共 ${total} 课";

  static String m39(wins, losses) => "胜 ${wins} · 负 ${losses}";

  static String m40(color) => "你 · ${color}";

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
    "AchievementGamesProgress": m0,
    "AchievementStreakProgress": m1,
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage("成就解锁"),
    "AchievementWinsProgress": m2,
    "Achievements": MessageLookupByLibrary.simpleMessage("成就"),
    "AdFailed": MessageLookupByLibrary.simpleMessage("广告暂不可用，请稍后再试。"),
    "AdLoading": MessageLookupByLibrary.simpleMessage("广告加载中…"),
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("电脑"),
    "AnalysisAccuracy": MessageLookupByLibrary.simpleMessage("准确率"),
    "AnalysisClean": MessageLookupByLibrary.simpleMessage("没有发现重大失误，下得好！"),
    "AnalysisCounts": m3,
    "AnalysisInaccuracy": MessageLookupByLibrary.simpleMessage("不精确"),
    "AnalysisKeyMoments": MessageLookupByLibrary.simpleMessage("关键时刻"),
    "AnalysisLoading": MessageLookupByLibrary.simpleMessage("正在分析每一步…"),
    "AnalysisLockedBody": MessageLookupByLibrary.simpleMessage(
      "高级版会评估你的准确率，统计你与教练选择一致的次数，并列出值得复盘的关键失误。",
    ),
    "AnalysisMistake": MessageLookupByLibrary.simpleMessage("失误"),
    "AnalysisMoment": m4,
    "AnalysisNoMoves": MessageLookupByLibrary.simpleMessage("这局没有可分析的决策。"),
    "AnalysisTitle": MessageLookupByLibrary.simpleMessage("对局分析"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("最高连胜"),
    "Black": MessageLookupByLibrary.simpleMessage("黑棋"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("黑棋获胜"),
    "BoardCell": m5,
    "BoardEmpty": MessageLookupByLibrary.simpleMessage("空格"),
    "BoardKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "使用方向键浏览棋盘，按回车键或空格键在标记的格子落子。",
    ),
    "BoardLastMove": MessageLookupByLibrary.simpleMessage("上一步落子"),
    "BoardLegalMove": MessageLookupByLibrary.simpleMessage("合法落子点"),
    "BoardReviewKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "使用方向键浏览棋盘。",
    ),
    "BoardSuggestedMove": MessageLookupByLibrary.simpleMessage("教练建议"),
    "Cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "Classic_15_Puzzle": MessageLookupByLibrary.simpleMessage("十五数字华容道"),
    "Classic_2048": MessageLookupByLibrary.simpleMessage("经典2048"),
    "Classic_Memory_Game": MessageLookupByLibrary.simpleMessage("经典记忆游戏"),
    "Classic_Minesweeper": MessageLookupByLibrary.simpleMessage("经典扫雷"),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage("经典黑白棋"),
    "Classical_Music_Box": MessageLookupByLibrary.simpleMessage("古典音乐盒"),
    "CoachAllowsCorner": MessageLookupByLibrary.simpleMessage("对手可以在下一回合占据角位。"),
    "CoachAnalyzing": MessageLookupByLibrary.simpleMessage("正在寻找值得研究的局面…"),
    "CoachAvoidCorner": MessageLookupByLibrary.simpleMessage(
      "另一个合法落子会让对手立即占角，这一步避开了该威胁。",
    ),
    "CoachComparison": m6,
    "CoachCorner": MessageLookupByLibrary.simpleMessage(
      "这一步可以占据角位，角位上的棋子不会被翻转。",
    ),
    "CoachEndsGame": MessageLookupByLibrary.simpleMessage(
      "走完这一步后，双方都无法落子，对局结束。",
    ),
    "CoachForPlayer": m7,
    "CoachJump": MessageLookupByLibrary.simpleMessage("前往这个局面"),
    "CoachMatched": m8,
    "CoachNoPosition": MessageLookupByLibrary.simpleMessage(
      "这局对局中没有可供尝试落子的局面。",
    ),
    "CoachPass": MessageLookupByLibrary.simpleMessage("对手没有合法应手，因此你可以再走一步。"),
    "CoachPositionTitle": MessageLookupByLibrary.simpleMessage("研究这个局面"),
    "CoachPractice": MessageLookupByLibrary.simpleMessage("试下这个局面"),
    "CoachReplies": m9,
    "CoachScope": MessageLookupByLibrary.simpleMessage(
      "简短搜索会提供值得尝试的思路，但不保证是最强的一步。",
    ),
    "CoachShareResult": MessageLookupByLibrary.simpleMessage("分享战绩"),
    "CoachSuggested": m10,
    "CoachTip": MessageLookupByLibrary.simpleMessage("教练提示"),
    "CoachTipLimitMessage": m11,
    "CoachTipLimitPremiumMessage": m12,
    "CoachTipLimitTitle": MessageLookupByLibrary.simpleMessage("今日免费提示已用完"),
    "CoachTipSuggestion": m13,
    "CoachTipWatchAd": MessageLookupByLibrary.simpleMessage("观看广告"),
    "CoachTipWithAd": MessageLookupByLibrary.simpleMessage("教练提示 · 观看广告"),
    "CoachTipWithPremium": MessageLookupByLibrary.simpleMessage("教练提示 · 高级版"),
    "CoachTipsLeft": m14,
    "CoachTitle": MessageLookupByLibrary.simpleMessage("策略教练"),
    "CoachTurnTitle": MessageLookupByLibrary.simpleMessage("值得回顾的局面"),
    "CoachUnavailable": MessageLookupByLibrary.simpleMessage(
      "暂时无法使用教练功能，你仍然可以逐步复盘。",
    ),
    "ComputerColor": m15,
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
    "Delete": MessageLookupByLibrary.simpleMessage("删除"),
    "DeleteSavedMatch": MessageLookupByLibrary.simpleMessage("删除对局"),
    "DeleteSavedMatchMessage": MessageLookupByLibrary.simpleMessage(
      "这局对局的复盘记录将从收藏中移除，统计数据保持不变。",
    ),
    "DeleteSavedMatchTitle": MessageLookupByLibrary.simpleMessage("删除这局对局？"),
    "Difficulty": MessageLookupByLibrary.simpleMessage("难度"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("简单"),
    "DifficultyExpert": MessageLookupByLibrary.simpleMessage("专家"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("困难"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("中等"),
    "DifficultySuperEasy": MessageLookupByLibrary.simpleMessage("超简单"),
    "ExpertSetupNote": MessageLookupByLibrary.simpleMessage(
      "专家难度计算更深，终局走法完美，思考时间可能稍长。",
    ),
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
    "GameSaveFailed": MessageLookupByLibrary.simpleMessage("无法保存对局。请在离开前重试。"),
    "GameSetup": MessageLookupByLibrary.simpleMessage("设置对局"),
    "GameStatusAnnouncement": m16,
    "GamesPlayed": MessageLookupByLibrary.simpleMessage("对局数"),
    "Garden_Catch_Bugs": MessageLookupByLibrary.simpleMessage("抓虫子"),
    "GetPremium": MessageLookupByLibrary.simpleMessage("获取高级版"),
    "GetPremiumWithPrice": m17,
    "GoPremium": MessageLookupByLibrary.simpleMessage("升级高级版"),
    "GuidedFirstGame": MessageLookupByLibrary.simpleMessage("跟着引导学下棋"),
    "GuidedFirstGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "练习翻子，了解角位，找到自己的节奏。",
    ),
    "Haptics": MessageLookupByLibrary.simpleMessage("触感反馈"),
    "Help": MessageLookupByLibrary.simpleMessage("帮助"),
    "Hint": MessageLookupByLibrary.simpleMessage("提示"),
    "HintWithAd": MessageLookupByLibrary.simpleMessage("合法落子点 · 观看广告"),
    "HintWithPremium": MessageLookupByLibrary.simpleMessage("合法落子点 · 高级版"),
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
    "MatchLibrary": MessageLookupByLibrary.simpleMessage("对局收藏"),
    "MatchLibraryDeleteError": MessageLookupByLibrary.simpleMessage(
      "无法删除这局对局，请重试。",
    ),
    "MatchLibraryEmptyBody": MessageLookupByLibrary.simpleMessage(
      "完成一局后，对局就会保存在这里。回顾每一步，发现下次可以尝试的新思路。",
    ),
    "MatchLibraryEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "你的棋局故事，从这里开始",
    ),
    "MatchLibraryLoadError": MessageLookupByLibrary.simpleMessage("无法加载对局收藏。"),
    "MatchLibraryOpen": MessageLookupByLibrary.simpleMessage("重温对局"),
    "MatchLibrarySaveError": MessageLookupByLibrary.simpleMessage(
      "无法将这局对局保存到收藏。",
    ),
    "MatchLibrarySubtitle": MessageLookupByLibrary.simpleMessage(
      "保留最近完成的100局，随时重温每一步。",
    ),
    "MilestoneCompleted": MessageLookupByLibrary.simpleMessage("已完成"),
    "Mint_Translate": MessageLookupByLibrary.simpleMessage("薄荷翻译"),
    "Money_Tracker": MessageLookupByLibrary.simpleMessage("极简记账"),
    "More": MessageLookupByLibrary.simpleMessage("更多"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("更多App"),
    "NewGame": MessageLookupByLibrary.simpleMessage("新游戏"),
    "NextMilestone": MessageLookupByLibrary.simpleMessage("下个目标"),
    "Novels_Hub": MessageLookupByLibrary.simpleMessage("英文小说站"),
    "OK": MessageLookupByLibrary.simpleMessage("好的"),
    "Opponent": MessageLookupByLibrary.simpleMessage("对手"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("完胜"),
    "Play": MessageLookupByLibrary.simpleMessage("开始游戏"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage("与好友在本设备上对战"),
    "PlayerTurn": m18,
    "PracticeBoardLabel": MessageLookupByLibrary.simpleMessage("策略练习棋盘"),
    "PracticeFlipped": m19,
    "PracticeInstructions": MessageLookupByLibrary.simpleMessage(
      "在任意标记的格子落子，观察局面如何变化。",
    ),
    "PracticeNoMoves": MessageLookupByLibrary.simpleMessage(
      "当前局面中，这一方没有合法落子点。",
    ),
    "PracticePlayed": m20,
    "PracticeReset": MessageLookupByLibrary.simpleMessage("尝试其他落子"),
    "PracticeSafe": MessageLookupByLibrary.simpleMessage("练习不会影响已保存的对局和统计数据。"),
    "PracticeTitle": MessageLookupByLibrary.simpleMessage("试下这个局面"),
    "Premium": MessageLookupByLibrary.simpleMessage("高级版"),
    "PremiumActive": MessageLookupByLibrary.simpleMessage("高级版已启用"),
    "PremiumAdFreeBody": MessageLookupByLibrary.simpleMessage(
      "没有横幅广告、开屏广告或激励广告。",
    ),
    "PremiumAdFreeTitle": MessageLookupByLibrary.simpleMessage("无广告"),
    "PremiumAnalysisBody": MessageLookupByLibrary.simpleMessage(
      "查看每局的准确率和关键失误，轻点即可跳到该局面。",
    ),
    "PremiumAnalysisTitle": MessageLookupByLibrary.simpleMessage("完整对局分析"),
    "PremiumExpertBody": MessageLookupByLibrary.simpleMessage(
      "挑战最强电脑：计算更深，终局完美无瑕。",
    ),
    "PremiumExpertTitle": MessageLookupByLibrary.simpleMessage("专家对手"),
    "PremiumHeadline": MessageLookupByLibrary.simpleMessage("升级到高级版"),
    "PremiumHintsBody": MessageLookupByLibrary.simpleMessage(
      "在中等、困难和专家难度显示所有合法落子点，无需观看广告。",
    ),
    "PremiumHintsBodyNoAds": MessageLookupByLibrary.simpleMessage(
      "在中等、困难和专家难度显示所有合法落子点。",
    ),
    "PremiumHintsTitle": MessageLookupByLibrary.simpleMessage("全难度落子提示"),
    "PremiumIncludes": MessageLookupByLibrary.simpleMessage("高级版包括"),
    "PremiumOneTime": m21,
    "PremiumRequired": MessageLookupByLibrary.simpleMessage("需要高级版"),
    "PremiumSettingsActiveSubtitle": MessageLookupByLibrary.simpleMessage(
      "谢谢你！所有高级版功能均已解锁。",
    ),
    "PremiumSettingsSubtitle": MessageLookupByLibrary.simpleMessage(
      "无广告、无限悔棋与提示、专家电脑等更多功能",
    ),
    "PremiumSubheadline": MessageLookupByLibrary.simpleMessage(
      "无广告畅玩，并解锁进阶工具，让每一局都更进一步。",
    ),
    "PremiumSubheadlineNoAds": MessageLookupByLibrary.simpleMessage(
      "解锁进阶工具，让每一局都更进一步。",
    ),
    "PremiumThemeLabel": m22,
    "PremiumThemesBody": MessageLookupByLibrary.simpleMessage("皇家与余烬棋桌，高级版专享。"),
    "PremiumThemesTitle": MessageLookupByLibrary.simpleMessage("专属棋盘主题"),
    "PremiumTipsBody": m23,
    "PremiumTipsTitle": MessageLookupByLibrary.simpleMessage("无限教练提示"),
    "PremiumUndoBody": MessageLookupByLibrary.simpleMessage(
      "任何难度都可随意悔棋，想退几步就退几步。",
    ),
    "PremiumUndoTitle": MessageLookupByLibrary.simpleMessage("无限悔棋"),
    "PremiumWelcomeBody": MessageLookupByLibrary.simpleMessage(
      "感谢你的支持！所有高级版功能均已解锁。",
    ),
    "PremiumWelcomeTitle": MessageLookupByLibrary.simpleMessage("你是高级版玩家"),
    "PrivacyOptions": MessageLookupByLibrary.simpleMessage("隐私选项"),
    "PrivacyOptionsSubtitle": MessageLookupByLibrary.simpleMessage(
      "更新你的广告隐私选择",
    ),
    "PrivacyPolicy": MessageLookupByLibrary.simpleMessage("隐私政策"),
    "PrivacyPolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "了解我们如何处理数据和广告",
    ),
    "PurchaseAlreadyOwned": MessageLookupByLibrary.simpleMessage("你已拥有高级版。"),
    "PurchaseCancelled": MessageLookupByLibrary.simpleMessage("已取消购买。"),
    "PurchaseFailed": MessageLookupByLibrary.simpleMessage("购买失败，请重试。"),
    "PurchasePending": MessageLookupByLibrary.simpleMessage("购买待批准…"),
    "PurchaseSuccess": MessageLookupByLibrary.simpleMessage("欢迎使用高级版！所有功能已解锁。"),
    "PurchaseUnavailable": MessageLookupByLibrary.simpleMessage("暂时无法购买。"),
    "PuzzleAllComplete": MessageLookupByLibrary.simpleMessage(
      "九题全部解开！随时重温任意局面，继续磨练棋艺。",
    ),
    "PuzzleBackToArchive": MessageLookupByLibrary.simpleMessage("返回练习列表"),
    "PuzzleBoardLabel": MessageLookupByLibrary.simpleMessage("练习题棋盘"),
    "PuzzleCompleted": MessageLookupByLibrary.simpleMessage("已解开"),
    "PuzzleCompletionSaveFailed": MessageLookupByLibrary.simpleMessage(
      "无法保存进度，请保持此页面打开并重试。",
    ),
    "PuzzleCornerDescription": MessageLookupByLibrary.simpleMessage(
      "找到安全的角位，形成夹击并翻子。",
    ),
    "PuzzleCornerHintOne": MessageLookupByLibrary.simpleMessage(
      "角位上的棋子不会被翻转，找一条可以形成夹击的线路。",
    ),
    "PuzzleCornerHintTwo": MessageLookupByLibrary.simpleMessage(
      "从目标角位向内寻找，直到你的棋子能夹住对手棋子。",
    ),
    "PuzzleCornerObjective": m24,
    "PuzzleCornerSkill": MessageLookupByLibrary.simpleMessage("占据角位"),
    "PuzzleCornerSuccess": MessageLookupByLibrary.simpleMessage(
      "成功占角！角位棋子将一直属于你，直到对局结束。",
    ),
    "PuzzleEndgameDescription": MessageLookupByLibrary.simpleMessage(
      "应对最佳应手，走好最后几步。",
    ),
    "PuzzleEndgameHintOne": MessageLookupByLibrary.simpleMessage(
      "最终棋子数量决定胜负，试着推算到最后。",
    ),
    "PuzzleEndgameHintTwo": MessageLookupByLibrary.simpleMessage(
      "比较对手的应手。少翻一些棋子，可能有助于保留最后一步。",
    ),
    "PuzzleEndgameObjective": m25,
    "PuzzleEndgameSkill": MessageLookupByLibrary.simpleMessage("赢下残局"),
    "PuzzleEndgameSuccess": MessageLookupByLibrary.simpleMessage(
      "成功赢下残局！你的选择经受住了最佳应手的考验。",
    ),
    "PuzzleEndgameTryAgain": MessageLookupByLibrary.simpleMessage(
      "面对最佳应对，这条路线无法确保获胜。请重新开始，比较其他落子。",
    ),
    "PuzzleHint": m26,
    "PuzzleHintCoordinate": m27,
    "PuzzleNext": MessageLookupByLibrary.simpleMessage("下一题"),
    "PuzzleNoResults": MessageLookupByLibrary.simpleMessage(
      "没有匹配的练习题，请尝试搜索技巧或题目编号。",
    ),
    "PuzzleNumber": m28,
    "PuzzleOpponentThinking": MessageLookupByLibrary.simpleMessage("正在考虑最佳应手…"),
    "PuzzlePassDescription": MessageLookupByLibrary.simpleMessage(
      "让对手没有合法落子点。",
    ),
    "PuzzlePassHintOne": MessageLookupByLibrary.simpleMessage(
      "只有对手没有合法落子点时，才会跳过回合。",
    ),
    "PuzzlePassHintTwo": MessageLookupByLibrary.simpleMessage(
      "比较每个候选落子之后，对手还可以走哪些位置。",
    ),
    "PuzzlePassObjective": m29,
    "PuzzlePassSkill": MessageLookupByLibrary.simpleMessage("争取再走一步"),
    "PuzzlePassSuccess": MessageLookupByLibrary.simpleMessage(
      "你争取到了下一步！对手没有合法落子点，对局继续。",
    ),
    "PuzzleProgress": m30,
    "PuzzleProgressLoadFailed": MessageLookupByLibrary.simpleMessage(
      "无法加载谜题进度。请重试。",
    ),
    "PuzzleRestart": MessageLookupByLibrary.simpleMessage("重新练习"),
    "PuzzleRevealHint": MessageLookupByLibrary.simpleMessage("查看提示"),
    "PuzzleSaveProgress": MessageLookupByLibrary.simpleMessage("保存进度"),
    "PuzzleSearch": MessageLookupByLibrary.simpleMessage("搜索练习题"),
    "PuzzleTryAgain": MessageLookupByLibrary.simpleMessage(
      "这一步还未达成目标，请重新开始，尝试其他走法。",
    ),
    "PuzzleYourMove": MessageLookupByLibrary.simpleMessage("轮到你落子"),
    "Puzzles": MessageLookupByLibrary.simpleMessage("棋局练习"),
    "PuzzlesSubtitle": MessageLookupByLibrary.simpleMessage("九个精选局面，每次练好一项技巧。"),
    "ReduceMotion": MessageLookupByLibrary.simpleMessage("减少动态效果"),
    "ReduceMotionSubtitle": MessageLookupByLibrary.simpleMessage(
      "尽量减少棋子运动和庆祝动画",
    ),
    "Relaxing_Up": MessageLookupByLibrary.simpleMessage("冥想Up"),
    "Rematch": MessageLookupByLibrary.simpleMessage("再来一局"),
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
    "RestorePurchaseHelp": m31,
    "RestorePurchases": MessageLookupByLibrary.simpleMessage("恢复购买"),
    "RestoreSuccess": MessageLookupByLibrary.simpleMessage("已恢复购买。"),
    "ResultCardError": MessageLookupByLibrary.simpleMessage("无法制作战绩卡。"),
    "ResultCardPreparing": MessageLookupByLibrary.simpleMessage("正在制作战绩卡…"),
    "ResultCardPreviewLabel": m32,
    "ResultCardShareFailed": MessageLookupByLibrary.simpleMessage(
      "暂时无法分享，请重试。",
    ),
    "ResultCardTitle": MessageLookupByLibrary.simpleMessage("分享战绩"),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage("复盘棋盘"),
    "ReviewCorners": m33,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("最终局面"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("回到开局"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("复盘"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("前往终局"),
    "ReviewMove": m34,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("下一步"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("上一步"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("初始局面"),
    "Rules": MessageLookupByLibrary.simpleMessage("规则"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "棋盘已为你保留，随时可以继续。",
    ),
    "SavedMatchScore": m35,
    "Saving_Ambulance": MessageLookupByLibrary.simpleMessage("拯救救护车"),
    "Settings": MessageLookupByLibrary.simpleMessage("设置"),
    "Share": MessageLookupByLibrary.simpleMessage("分享"),
    "ShareResult": m36,
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
    "ThemeEmber": MessageLookupByLibrary.simpleMessage("余烬"),
    "ThemeNight": MessageLookupByLibrary.simpleMessage("夜间"),
    "ThemeRoyal": MessageLookupByLibrary.simpleMessage("皇家"),
    "Tie": MessageLookupByLibrary.simpleMessage("平局"),
    "Ties": MessageLookupByLibrary.simpleMessage("平局"),
    "TryAgain": MessageLookupByLibrary.simpleMessage("重试"),
    "TurnPassed": m37,
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
    "TutorialProgress": m38,
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
    "UndoUnlimited": MessageLookupByLibrary.simpleMessage("悔棋 · 无限"),
    "UndoWithAd": MessageLookupByLibrary.simpleMessage("悔棋 · 观看广告"),
    "UndoWithPremium": MessageLookupByLibrary.simpleMessage("悔棋 · 高级版"),
    "UnlockWithPremium": MessageLookupByLibrary.simpleMessage("用高级版解锁"),
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
    "WinsLosses": m39,
    "World_Weather_Live": MessageLookupByLibrary.simpleMessage("极简天气"),
    "Yes_Habit": MessageLookupByLibrary.simpleMessage("签签习惯"),
    "YouColor": m40,
    "YouLose": MessageLookupByLibrary.simpleMessage("你输了"),
    "YouWin": MessageLookupByLibrary.simpleMessage("你赢了！"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("轮到你了"),
    "falling_block_puzzle": MessageLookupByLibrary.simpleMessage("经典俄罗斯掌机方块"),
  };
}
