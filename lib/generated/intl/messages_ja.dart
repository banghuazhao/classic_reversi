// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m0(coordinate, piece) => "${coordinate}、${piece}";

  static String m1(color) => "コンピューター · ${color}";

  static String m2(status, black, white) => "${status}。黒 ${black}、白 ${white}。";

  static String m3(color) => "${color}の番です";

  static String m4(black, white) => "角 · 黒 ${black} · 白 ${white}";

  static String m5(move, total) => "${move}手目／全${total}手";

  static String m6(result, black, white, mode) =>
      "${result} · 黒 ${black} – 白 ${white}（${mode}）— クラシックリバーシ";

  static String m7(passed, current) =>
      "${passed}は打てる場所がありません。もう一度${current}の番です。";

  static String m8(step, total) => "レッスン ${step}／${total}";

  static String m9(wins, losses) => "勝ち ${wins} · 負け ${losses}";

  static String m10(color) => "あなた · ${color}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Accessibility": MessageLookupByLibrary.simpleMessage("アクセシビリティ"),
    "AchDailyChallenge": MessageLookupByLibrary.simpleMessage("デイリーチャンピオン"),
    "AchFirstWin": MessageLookupByLibrary.simpleMessage("初勝利"),
    "AchGames10": MessageLookupByLibrary.simpleMessage("10対局"),
    "AchGames50": MessageLookupByLibrary.simpleMessage("50対局"),
    "AchPerfectGame": MessageLookupByLibrary.simpleMessage("パーフェクトゲーム"),
    "AchWinHard": MessageLookupByLibrary.simpleMessage("ハード勝利"),
    "AchWinStreak3": MessageLookupByLibrary.simpleMessage("3連勝"),
    "AchWinStreak5": MessageLookupByLibrary.simpleMessage("5連勝"),
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage("実績解除"),
    "Achievements": MessageLookupByLibrary.simpleMessage("実績"),
    "AdFailed": MessageLookupByLibrary.simpleMessage(
      "広告を表示できません。後でもう一度お試しください。",
    ),
    "AdLoading": MessageLookupByLibrary.simpleMessage("広告を読み込み中…"),
    "AdsRemoved": MessageLookupByLibrary.simpleMessage("広告は削除されました"),
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("コンピューター"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("最高連勝"),
    "Black": MessageLookupByLibrary.simpleMessage("黒"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("黒の勝ち"),
    "BoardCell": m0,
    "BoardEmpty": MessageLookupByLibrary.simpleMessage("空きマス"),
    "BoardKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "矢印キーで盤面を移動し、Enterキーまたはスペースキーで印のあるマスに打ちます。",
    ),
    "BoardLastMove": MessageLookupByLibrary.simpleMessage("直前の一手"),
    "BoardLegalMove": MessageLookupByLibrary.simpleMessage("打てるマス"),
    "BoardReviewKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "矢印キーで盤面を移動できます。",
    ),
    "Cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
    "Classic_15_Puzzle": MessageLookupByLibrary.simpleMessage(
      "Classic 15 Puzzle",
    ),
    "Classic_2048": MessageLookupByLibrary.simpleMessage("Classic 2048"),
    "Classic_Memory_Game": MessageLookupByLibrary.simpleMessage(
      "Classic Memory Game",
    ),
    "Classic_Minesweeper": MessageLookupByLibrary.simpleMessage(
      "Classic Minesweeper",
    ),
    "Classic_Reversi": MessageLookupByLibrary.simpleMessage("Classic Reversi"),
    "ComputerColor": m1,
    "ComputerThinking": MessageLookupByLibrary.simpleMessage("コンピューターが考えています…"),
    "ContinueGame": MessageLookupByLibrary.simpleMessage("対局を続ける"),
    "Crazy_Pyramid": MessageLookupByLibrary.simpleMessage("Crazy Pyramid"),
    "CurrentStreak": MessageLookupByLibrary.simpleMessage("連勝"),
    "DailyChallenge": MessageLookupByLibrary.simpleMessage("デイリーチャレンジ"),
    "DailyChallengeSubtitle": MessageLookupByLibrary.simpleMessage(
      "今日の難問をハードでクリア",
    ),
    "DailyCompleted": MessageLookupByLibrary.simpleMessage(
      "本日クリア済み — もう一度遊べます",
    ),
    "Difficulty": MessageLookupByLibrary.simpleMessage("難易度"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("かんたん"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("むずかしい"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("ふつう"),
    "DifficultySuperEasy": MessageLookupByLibrary.simpleMessage("とてもかんたん"),
    "FeedbackBalanced": MessageLookupByLibrary.simpleMessage("標準"),
    "FeedbackGentle": MessageLookupByLibrary.simpleMessage("控えめ"),
    "FeedbackIntensity": MessageLookupByLibrary.simpleMessage("フィードバックの強さ"),
    "FeedbackLively": MessageLookupByLibrary.simpleMessage("にぎやか"),
    "FirstPlayerComputer": MessageLookupByLibrary.simpleMessage("コンピューター"),
    "FirstPlayerHuman": MessageLookupByLibrary.simpleMessage("プレイヤー"),
    "FirstPlayerRandom": MessageLookupByLibrary.simpleMessage("ランダム"),
    "Flappy_Fish": MessageLookupByLibrary.simpleMessage("Flappy Fish"),
    "GameOver": MessageLookupByLibrary.simpleMessage("ゲーム終了"),
    "GameSetup": MessageLookupByLibrary.simpleMessage("対局の設定"),
    "GameStatusAnnouncement": m2,
    "GamesPlayed": MessageLookupByLibrary.simpleMessage("対局数"),
    "Garden_Catch_Bugs": MessageLookupByLibrary.simpleMessage(
      "Garden: Catch Bugs",
    ),
    "GuidedFirstGame": MessageLookupByLibrary.simpleMessage("ガイド付きの対局で練習"),
    "GuidedFirstGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "石の返し方や角の大切さを学び、自分のペースで慣れていきましょう。",
    ),
    "Haptics": MessageLookupByLibrary.simpleMessage("触覚フィードバック"),
    "Help": MessageLookupByLibrary.simpleMessage("ヘルプ"),
    "Hint": MessageLookupByLibrary.simpleMessage("ヒント"),
    "HintWithAd": MessageLookupByLibrary.simpleMessage("打てるマス · 広告を見る"),
    "HintsEnabled": MessageLookupByLibrary.simpleMessage("この対局でヒントが有効になりました。"),
    "Home": MessageLookupByLibrary.simpleMessage("ホーム"),
    "HomeTagline": MessageLookupByLibrary.simpleMessage("少しの戦略と、自分だけのひとときを。"),
    "How_to_play": MessageLookupByLibrary.simpleMessage("遊び方紹介"),
    "How_to_play_explain": MessageLookupByLibrary.simpleMessage(
      "ゲームでは、それぞれ黒と白を担当する2人のプレイヤーが交互に盤面へ石を打っていき、最終的に盤上の石が多かったほうが勝ちとなる。相手の石を自分の石で挟んだときは、相手の石を裏返すことで、自分の石にする。最後にプレイ可能な空のマスがいっぱいになったときに、ディスクの大部分を自分の色で表示するようにすることです.",
    ),
    "KeepPlaying": MessageLookupByLibrary.simpleMessage("対局を続ける"),
    "More": MessageLookupByLibrary.simpleMessage("More"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("More Apps"),
    "NewGame": MessageLookupByLibrary.simpleMessage("新しい対局"),
    "OK": MessageLookupByLibrary.simpleMessage("OK"),
    "Opponent": MessageLookupByLibrary.simpleMessage("対戦相手"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("パーフェクト勝ち"),
    "Play": MessageLookupByLibrary.simpleMessage("対局する"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage("この端末で友達と対戦する"),
    "PlayerTurn": m3,
    "PrivacyOptions": MessageLookupByLibrary.simpleMessage("プライバシー設定"),
    "PrivacyOptionsSubtitle": MessageLookupByLibrary.simpleMessage(
      "広告のプライバシー選択を更新",
    ),
    "PrivacyPolicy": MessageLookupByLibrary.simpleMessage("プライバシーポリシー"),
    "PrivacyPolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "データと広告の取り扱いについて",
    ),
    "PurchaseAlreadyOwned": MessageLookupByLibrary.simpleMessage(
      "広告削除はすでに購入済みです。",
    ),
    "PurchaseCancelled": MessageLookupByLibrary.simpleMessage("購入をキャンセルしました。"),
    "PurchaseFailed": MessageLookupByLibrary.simpleMessage(
      "購入に失敗しました。もう一度お試しください。",
    ),
    "PurchasePending": MessageLookupByLibrary.simpleMessage("購入の承認待ちです…"),
    "PurchaseSuccess": MessageLookupByLibrary.simpleMessage(
      "広告を削除しました。ありがとうございます！",
    ),
    "PurchaseUnavailable": MessageLookupByLibrary.simpleMessage("現在購入できません。"),
    "ReduceMotion": MessageLookupByLibrary.simpleMessage("動きを減らす"),
    "ReduceMotionSubtitle": MessageLookupByLibrary.simpleMessage(
      "駒の動きとお祝い演出を最小限にします",
    ),
    "Rematch": MessageLookupByLibrary.simpleMessage("再戦"),
    "RemoveAds": MessageLookupByLibrary.simpleMessage("広告を削除"),
    "ReplaceSavedGameMessage": MessageLookupByLibrary.simpleMessage(
      "途中の対局は新しい対局に置き換わります。ホームから続きを遊ぶこともできます。",
    ),
    "ReplaceSavedGameTitle": MessageLookupByLibrary.simpleMessage(
      "新しい対局を始めますか？",
    ),
    "RestartConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "現在の局面は開始時の局面に戻ります。",
    ),
    "RestartConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "この対局を最初からやり直しますか？",
    ),
    "RestartGame": MessageLookupByLibrary.simpleMessage("対局をやり直す"),
    "RestoreNothing": MessageLookupByLibrary.simpleMessage("復元できる購入はありません。"),
    "RestorePurchases": MessageLookupByLibrary.simpleMessage("購入を復元"),
    "RestoreSuccess": MessageLookupByLibrary.simpleMessage("購入を復元しました。"),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage("対局を振り返る盤面"),
    "ReviewCorners": m4,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("終了時の局面"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("最初へ"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("対局を振り返る"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("最後へ"),
    "ReviewMove": m5,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("次の手"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("前の手"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("開始時の局面"),
    "Rules": MessageLookupByLibrary.simpleMessage("ルール"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage("いつでも続きから遊べます。"),
    "Settings": MessageLookupByLibrary.simpleMessage("設定"),
    "Share": MessageLookupByLibrary.simpleMessage("共有"),
    "ShareResult": m6,
    "Sound": MessageLookupByLibrary.simpleMessage("サウンド"),
    "Space_Jumper": MessageLookupByLibrary.simpleMessage("Space Jumper"),
    "StartGame": MessageLookupByLibrary.simpleMessage("ゲーム開始"),
    "StartNewGame": MessageLookupByLibrary.simpleMessage("新しい対局を始める"),
    "Stats": MessageLookupByLibrary.simpleMessage("統計"),
    "Theme": MessageLookupByLibrary.simpleMessage("テーマ"),
    "ThemeClassic": MessageLookupByLibrary.simpleMessage("クラシック"),
    "ThemeContrast": MessageLookupByLibrary.simpleMessage("ハイコントラスト"),
    "ThemeNight": MessageLookupByLibrary.simpleMessage("ナイト"),
    "Tie": MessageLookupByLibrary.simpleMessage("引き分け"),
    "Ties": MessageLookupByLibrary.simpleMessage("引き分け"),
    "TurnPassed": m7,
    "TutorialBoardLabel": MessageLookupByLibrary.simpleMessage("練習用の盤面"),
    "TutorialCaptureBody": MessageLookupByLibrary.simpleMessage(
      "あなたは黒です。印のあるマスをタップして、白い石を2つの黒い石で挟みましょう。",
    ),
    "TutorialCaptureDoneBody": MessageLookupByLibrary.simpleMessage(
      "挟まれた白い石が黒に変わります。次は白が打ち、その後またあなたの番です。",
    ),
    "TutorialCaptureDoneTitle": MessageLookupByLibrary.simpleMessage("石を返せました"),
    "TutorialCaptureTitle": MessageLookupByLibrary.simpleMessage("はじめて石を返す"),
    "TutorialCompleteBody": MessageLookupByLibrary.simpleMessage(
      "終了時に石が多い方の勝ちです。打てる場所がないときは自動でパスします。まずは「かんたん」で始め、慣れたら難易度を上げましょう。",
    ),
    "TutorialCompleteTitle": MessageLookupByLibrary.simpleMessage("準備ができました"),
    "TutorialCornersBody": MessageLookupByLibrary.simpleMessage(
      "この練習用の局面で、印のあるA1の角をタップしましょう。角の石は返されません。",
    ),
    "TutorialCornersTitle": MessageLookupByLibrary.simpleMessage("角を取る"),
    "TutorialNext": MessageLookupByLibrary.simpleMessage("続ける"),
    "TutorialPlayEasy": MessageLookupByLibrary.simpleMessage("かんたんで対局する"),
    "TutorialProgress": m8,
    "TutorialReplyBody": MessageLookupByLibrary.simpleMessage(
      "白が打ちました。印のあるマスをタップして、もう一度石を返しましょう。",
    ),
    "TutorialReplyDoneBody": MessageLookupByLibrary.simpleMessage(
      "一巡できました。今度は練習用の局面で角を取ってみましょう。",
    ),
    "TutorialSkip": MessageLookupByLibrary.simpleMessage("チュートリアルをスキップ"),
    "TutorialTitle": MessageLookupByLibrary.simpleMessage("遊びながら学ぶ"),
    "TwoPlayersMode": MessageLookupByLibrary.simpleMessage("2人対戦（同じ端末で交互に）"),
    "Undo": MessageLookupByLibrary.simpleMessage("待った"),
    "UndoWithAd": MessageLookupByLibrary.simpleMessage("待った · 広告を見る"),
    "Watch": MessageLookupByLibrary.simpleMessage("見る"),
    "WatchAd": MessageLookupByLibrary.simpleMessage("広告を見る"),
    "WatchAdForHint": MessageLookupByLibrary.simpleMessage("短い広告を見て合法手を表示します。"),
    "WatchAdForUndo": MessageLookupByLibrary.simpleMessage("短い広告を見て一手戻します。"),
    "White": MessageLookupByLibrary.simpleMessage("白"),
    "WhiteWins": MessageLookupByLibrary.simpleMessage("白の勝ち"),
    "WhoGoesFirst": MessageLookupByLibrary.simpleMessage("先手はどちら？"),
    "WinRate": MessageLookupByLibrary.simpleMessage("勝率"),
    "WinsByDifficulty": MessageLookupByLibrary.simpleMessage("難易度別勝利"),
    "WinsLosses": m9,
    "YouColor": m10,
    "YouLose": MessageLookupByLibrary.simpleMessage("負け"),
    "YouWin": MessageLookupByLibrary.simpleMessage("勝ち！"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("あなたの番です"),
    "falling_block_puzzle": MessageLookupByLibrary.simpleMessage(
      "Falling Block Puzzle",
    ),
  };
}
