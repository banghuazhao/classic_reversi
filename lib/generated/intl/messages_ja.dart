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

  static String m0(current, target) => "対局数：${current}／${target}";

  static String m1(current, target) => "連勝数：${current}／${target}";

  static String m2(current, target) => "勝利数：${current}／${target}";

  static String m3(coordinate, piece) => "${coordinate}、${piece}";

  static String m4(actual, suggested) => "実際の手 ${actual} · 試す手 ${suggested}";

  static String m5(player) => "${player}の手を考える";

  static String m6(coordinate) => "あなたは${coordinate}に打ちました。この手の狙いを振り返りましょう。";

  static String m7(count) => "相手が打てる手の数：${count}。";

  static String m8(coordinate) => "おすすめの手：${coordinate}";

  static String m9(color) => "コンピューター · ${color}";

  static String m10(status, black, white) => "${status}。黒 ${black}、白 ${white}。";

  static String m11(color) => "${color}の番です";

  static String m12(count) => "返した石：${count}";

  static String m13(coordinate) => "${coordinate}に打ちました";

  static String m14(color, coordinate) =>
      "${color}で打ちます。一手で${coordinate}の角を取りましょう。";

  static String m15(color) => "${color}で打ちます。相手が最善の手を打っても、この終盤で勝ち切りましょう。";

  static String m16(number) => "ヒント ${number}／3";

  static String m17(coordinate) => "${coordinate}を試しましょう。";

  static String m18(number) => "問題 ${number}";

  static String m19(color) => "${color}で打ちます。対局を終わらせずに相手をパスさせ、もう一度自分の番にしましょう。";

  static String m20(completed, total) => "${completed}／${total}問クリア";

  static String m21(result, score, mode, date) =>
      "${result}。${score}。${mode}。${date}。";

  static String m22(black, white) => "角 · 黒 ${black} · 白 ${white}";

  static String m23(move, total) => "${move}手目／全${total}手";

  static String m24(black, white) => "黒 ${black} · 白 ${white}";

  static String m25(result, black, white, mode) =>
      "${result} · 黒 ${black} – 白 ${white}（${mode}）— クラシックリバーシ";

  static String m26(passed, current) =>
      "${passed}は打てる場所がありません。もう一度${current}の番です。";

  static String m27(step, total) => "レッスン ${step}／${total}";

  static String m28(wins, losses) => "勝ち ${wins} · 負け ${losses}";

  static String m29(color) => "あなた · ${color}";

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
    "AchievementGamesProgress": m0,
    "AchievementStreakProgress": m1,
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage("実績解除"),
    "AchievementWinsProgress": m2,
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
    "BoardCell": m3,
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
    "CoachAllowsCorner": MessageLookupByLibrary.simpleMessage(
      "次のターンで相手に角を取られる可能性があります。",
    ),
    "CoachAnalyzing": MessageLookupByLibrary.simpleMessage(
      "考えるヒントになる局面を探しています…",
    ),
    "CoachAvoidCorner": MessageLookupByLibrary.simpleMessage(
      "ほかの合法手では相手にすぐ角を取られます。この手なら、その危険を避けられます。",
    ),
    "CoachComparison": m4,
    "CoachCorner": MessageLookupByLibrary.simpleMessage(
      "この手で角を取れます。角の石は返されません。",
    ),
    "CoachEndsGame": MessageLookupByLibrary.simpleMessage(
      "この手の後は両者とも打てる場所がなくなり、対局が終了します。",
    ),
    "CoachForPlayer": m5,
    "CoachJump": MessageLookupByLibrary.simpleMessage("この局面へ移動"),
    "CoachMatched": m6,
    "CoachNoPosition": MessageLookupByLibrary.simpleMessage(
      "この対局には、手を試せる局面がありません。",
    ),
    "CoachPass": MessageLookupByLibrary.simpleMessage(
      "相手に打てる場所がないので、もう一度あなたの番です。",
    ),
    "CoachPositionTitle": MessageLookupByLibrary.simpleMessage("この局面を考える"),
    "CoachPractice": MessageLookupByLibrary.simpleMessage("この局面で試す"),
    "CoachReplies": m7,
    "CoachScope": MessageLookupByLibrary.simpleMessage(
      "短い読みで候補を提案しています。最善手を保証するものではありません。",
    ),
    "CoachShareResult": MessageLookupByLibrary.simpleMessage("結果をシェア"),
    "CoachSuggested": m8,
    "CoachTitle": MessageLookupByLibrary.simpleMessage("戦略コーチ"),
    "CoachTurnTitle": MessageLookupByLibrary.simpleMessage("振り返りたい局面"),
    "CoachUnavailable": MessageLookupByLibrary.simpleMessage(
      "現在コーチ機能を利用できません。各手の振り返りは引き続き行えます。",
    ),
    "ComputerColor": m9,
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
    "Delete": MessageLookupByLibrary.simpleMessage("削除"),
    "DeleteSavedMatch": MessageLookupByLibrary.simpleMessage("対局を削除"),
    "DeleteSavedMatchMessage": MessageLookupByLibrary.simpleMessage(
      "この対局の記録をライブラリから削除します。統計は変わりません。",
    ),
    "DeleteSavedMatchTitle": MessageLookupByLibrary.simpleMessage(
      "この対局を削除しますか？",
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
    "GameSaveFailed": MessageLookupByLibrary.simpleMessage(
      "ゲームを保存できませんでした。終了する前にもう一度お試しください。",
    ),
    "GameSetup": MessageLookupByLibrary.simpleMessage("対局の設定"),
    "GameStatusAnnouncement": m10,
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
    "MatchLibrary": MessageLookupByLibrary.simpleMessage("対局ライブラリ"),
    "MatchLibraryDeleteError": MessageLookupByLibrary.simpleMessage(
      "この対局を削除できませんでした。もう一度お試しください。",
    ),
    "MatchLibraryEmptyBody": MessageLookupByLibrary.simpleMessage(
      "対局を終えると、ここに保存されます。一手ずつ振り返って、次の対局のヒントを見つけましょう。",
    ),
    "MatchLibraryEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "あなたの記録はここから",
    ),
    "MatchLibraryLoadError": MessageLookupByLibrary.simpleMessage(
      "対局ライブラリを読み込めませんでした。",
    ),
    "MatchLibraryOpen": MessageLookupByLibrary.simpleMessage("対局を振り返る"),
    "MatchLibrarySaveError": MessageLookupByLibrary.simpleMessage(
      "この対局をライブラリに保存できませんでした。",
    ),
    "MatchLibrarySubtitle": MessageLookupByLibrary.simpleMessage(
      "最近終了した100局を、いつでも振り返れます。",
    ),
    "MilestoneCompleted": MessageLookupByLibrary.simpleMessage("達成済み"),
    "More": MessageLookupByLibrary.simpleMessage("More"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("More Apps"),
    "NewGame": MessageLookupByLibrary.simpleMessage("新しい対局"),
    "NextMilestone": MessageLookupByLibrary.simpleMessage("次の目標"),
    "OK": MessageLookupByLibrary.simpleMessage("OK"),
    "Opponent": MessageLookupByLibrary.simpleMessage("対戦相手"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("パーフェクト勝ち"),
    "Play": MessageLookupByLibrary.simpleMessage("対局する"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage("この端末で友達と対戦する"),
    "PlayerTurn": m11,
    "PracticeBoardLabel": MessageLookupByLibrary.simpleMessage("戦略を練習する盤面"),
    "PracticeFlipped": m12,
    "PracticeInstructions": MessageLookupByLibrary.simpleMessage(
      "印のあるマスに打って、何が変わるか見てみましょう。",
    ),
    "PracticeNoMoves": MessageLookupByLibrary.simpleMessage(
      "この局面では、この色で打てる場所がありません。",
    ),
    "PracticePlayed": m13,
    "PracticeReset": MessageLookupByLibrary.simpleMessage("ほかの手を試す"),
    "PracticeSafe": MessageLookupByLibrary.simpleMessage(
      "練習は保存した対局や統計に影響しません。",
    ),
    "PracticeTitle": MessageLookupByLibrary.simpleMessage("この局面で試す"),
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
    "PurchaseBenefitAds": MessageLookupByLibrary.simpleMessage(
      "バナー広告とアプリ起動時の広告を削除。",
    ),
    "PurchaseBenefitHints": MessageLookupByLibrary.simpleMessage(
      "コンピューター対戦のすべての難易度で、広告を見ずに打てるマスを表示できます。",
    ),
    "PurchaseBenefitOnce": MessageLookupByLibrary.simpleMessage(
      "買い切りで、定期購入はありません。App Storeアカウントから復元できます。",
    ),
    "PurchaseBenefitUndo": MessageLookupByLibrary.simpleMessage(
      "広告を見ずに「むずかしい」で毎ターン1回待ったができます。",
    ),
    "PurchaseBenefits": MessageLookupByLibrary.simpleMessage(
      "一度の購入でバナー広告とアプリ起動時の広告を削除し、「むずかしい」での待ったと、打てるマスのヒントを広告なしで利用できます。同じApp Storeアカウントを使う端末で復元できます。",
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
    "PuzzleAllComplete": MessageLookupByLibrary.simpleMessage(
      "9問すべてクリアしました。好きな局面をもう一度試して、腕を磨きましょう。",
    ),
    "PuzzleBackToArchive": MessageLookupByLibrary.simpleMessage("問題一覧に戻る"),
    "PuzzleBoardLabel": MessageLookupByLibrary.simpleMessage("練習問題の盤面"),
    "PuzzleCompleted": MessageLookupByLibrary.simpleMessage("クリア済み"),
    "PuzzleCompletionSaveFailed": MessageLookupByLibrary.simpleMessage(
      "進捗を保存できませんでした。この画面を開いたまま、もう一度お試しください。",
    ),
    "PuzzleCornerDescription": MessageLookupByLibrary.simpleMessage(
      "挟める石の並びを見つけて、安全に角を取りましょう。",
    ),
    "PuzzleCornerHintOne": MessageLookupByLibrary.simpleMessage(
      "角の石は返されません。相手の石を挟める並びを探しましょう。",
    ),
    "PuzzleCornerHintTwo": MessageLookupByLibrary.simpleMessage(
      "狙う角から内側へたどり、相手の石を自分の石で挟める並びを探しましょう。",
    ),
    "PuzzleCornerObjective": m14,
    "PuzzleCornerSkill": MessageLookupByLibrary.simpleMessage("角を取る"),
    "PuzzleCornerSuccess": MessageLookupByLibrary.simpleMessage(
      "角を取れました。角の石は、対局が終わるまで自分のものです。",
    ),
    "PuzzleEndgameDescription": MessageLookupByLibrary.simpleMessage(
      "相手の最善の応手を読み、最後の手まで打ちましょう。",
    ),
    "PuzzleEndgameHintOne": MessageLookupByLibrary.simpleMessage(
      "最後の石の数で勝敗が決まります。終了まで読み、石を数えましょう。",
    ),
    "PuzzleEndgameHintTwo": MessageLookupByLibrary.simpleMessage(
      "相手の応手を比べましょう。少なく返す手なら、最後の一手を残せるかもしれません。",
    ),
    "PuzzleEndgameObjective": m15,
    "PuzzleEndgameSkill": MessageLookupByLibrary.simpleMessage("勝って終える"),
    "PuzzleEndgameSuccess": MessageLookupByLibrary.simpleMessage(
      "終盤を勝ち切れました。相手の最善の応手にも対応できました。",
    ),
    "PuzzleEndgameTryAgain": MessageLookupByLibrary.simpleMessage(
      "この手順では、相手が最善を尽くすと勝ち切れません。最初からやり直し、ほかの手を比べましょう。",
    ),
    "PuzzleHint": m16,
    "PuzzleHintCoordinate": m17,
    "PuzzleNext": MessageLookupByLibrary.simpleMessage("次の問題"),
    "PuzzleNoResults": MessageLookupByLibrary.simpleMessage(
      "一致する問題がありません。練習したい技や問題番号で検索してください。",
    ),
    "PuzzleNumber": m18,
    "PuzzleOpponentThinking": MessageLookupByLibrary.simpleMessage(
      "最善の応手を検討中…",
    ),
    "PuzzlePassDescription": MessageLookupByLibrary.simpleMessage(
      "相手が打てる場所をなくしましょう。",
    ),
    "PuzzlePassHintOne": MessageLookupByLibrary.simpleMessage(
      "相手に打てる場所がないときにだけ、パスになります。",
    ),
    "PuzzlePassHintTwo": MessageLookupByLibrary.simpleMessage(
      "それぞれの候補の後で、相手が打てる手を比べましょう。",
    ),
    "PuzzlePassObjective": m19,
    "PuzzlePassSkill": MessageLookupByLibrary.simpleMessage("もう一度自分の番にする"),
    "PuzzlePassSuccess": MessageLookupByLibrary.simpleMessage(
      "もう一度あなたの番です。相手はパスし、対局は続きます。",
    ),
    "PuzzleProgress": m20,
    "PuzzleProgressLoadFailed": MessageLookupByLibrary.simpleMessage(
      "パズルの進捗を読み込めませんでした。もう一度お試しください。",
    ),
    "PuzzleRestart": MessageLookupByLibrary.simpleMessage("問題をやり直す"),
    "PuzzleRevealHint": MessageLookupByLibrary.simpleMessage("ヒントを見る"),
    "PuzzleSaveProgress": MessageLookupByLibrary.simpleMessage("進捗を保存"),
    "PuzzleSearch": MessageLookupByLibrary.simpleMessage("問題を検索"),
    "PuzzleTryAgain": MessageLookupByLibrary.simpleMessage(
      "この手では条件を達成できません。最初からやり直し、ほかの手順を試しましょう。",
    ),
    "PuzzleYourMove": MessageLookupByLibrary.simpleMessage("あなたの番です"),
    "Puzzles": MessageLookupByLibrary.simpleMessage("練習問題"),
    "PuzzlesSubtitle": MessageLookupByLibrary.simpleMessage(
      "厳選した9つの局面で、一つずつ上達しましょう。",
    ),
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
    "ResultCardError": MessageLookupByLibrary.simpleMessage(
      "結果カードを作成できませんでした。",
    ),
    "ResultCardPreparing": MessageLookupByLibrary.simpleMessage("結果カードを作成中…"),
    "ResultCardPreviewLabel": m21,
    "ResultCardShareFailed": MessageLookupByLibrary.simpleMessage(
      "現在シェアできません。もう一度お試しください。",
    ),
    "ResultCardTitle": MessageLookupByLibrary.simpleMessage("結果をシェア"),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage("対局を振り返る盤面"),
    "ReviewCorners": m22,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("終了時の局面"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("最初へ"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("対局を振り返る"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("最後へ"),
    "ReviewMove": m23,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("次の手"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("前の手"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("開始時の局面"),
    "Rules": MessageLookupByLibrary.simpleMessage("ルール"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage("いつでも続きから遊べます。"),
    "SavedMatchScore": m24,
    "Settings": MessageLookupByLibrary.simpleMessage("設定"),
    "Share": MessageLookupByLibrary.simpleMessage("共有"),
    "ShareResult": m25,
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
    "TryAgain": MessageLookupByLibrary.simpleMessage("もう一度試す"),
    "TurnPassed": m26,
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
    "TutorialProgress": m27,
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
    "WinsLosses": m28,
    "YouColor": m29,
    "YouLose": MessageLookupByLibrary.simpleMessage("負け"),
    "YouWin": MessageLookupByLibrary.simpleMessage("勝ち！"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("あなたの番です"),
    "falling_block_puzzle": MessageLookupByLibrary.simpleMessage(
      "Falling Block Puzzle",
    ),
  };
}
