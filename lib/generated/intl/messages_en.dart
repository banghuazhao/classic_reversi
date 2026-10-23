// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(current, target) => "Games: ${current} of ${target}";

  static String m1(current, target) =>
      "Consecutive wins: ${current} of ${target}";

  static String m2(current, target) => "Wins: ${current} of ${target}";

  static String m3(coordinate, piece) => "${coordinate}, ${piece}";

  static String m4(actual, suggested) =>
      "Played ${actual} · Explore ${suggested}";

  static String m5(player) => "Ideas for ${player}";

  static String m6(coordinate) =>
      "You played ${coordinate}. Revisit the ideas behind it.";

  static String m7(count) => "Legal replies for your opponent: ${count}.";

  static String m8(coordinate) => "Suggested move: ${coordinate}";

  static String m9(color) => "Computer · ${color}";

  static String m10(status, black, white) =>
      "${status}. Black ${black}, White ${white}.";

  static String m11(color) => "${color} to play";

  static String m12(count) => "Discs flipped: ${count}";

  static String m13(coordinate) => "You played ${coordinate}";

  static String m14(color, coordinate) =>
      "Play as ${color}. Capture corner ${coordinate} in one move.";

  static String m15(color) =>
      "Play as ${color}. Win this endgame against the best replies.";

  static String m16(number) => "Hint ${number} of 3";

  static String m17(coordinate) => "Try ${coordinate}.";

  static String m18(number) => "Puzzle ${number}";

  static String m19(color) =>
      "Play as ${color}. Force a pass so you move again, without ending the game.";

  static String m20(completed, total) => "${completed} of ${total} solved";

  static String m21(result, score, mode, date) =>
      "${result}. ${score}. ${mode}. ${date}.";

  static String m22(black, white) =>
      "Corners · Black ${black} · White ${white}";

  static String m23(move, total) => "Move ${move} of ${total}";

  static String m24(black, white) => "Black ${black} · White ${white}";

  static String m25(result, black, white, mode) =>
      "${result} · Black ${black} – White ${white} (${mode}) — Classic Reversi";

  static String m26(passed, current) =>
      "${passed} has no legal moves. ${current} plays again.";

  static String m27(step, total) => "Lesson ${step} of ${total}";

  static String m28(wins, losses) => "Wins ${wins} · Losses ${losses}";

  static String m29(color) => "You · ${color}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Accessibility": MessageLookupByLibrary.simpleMessage("Accessibility"),
    "AchDailyChallenge": MessageLookupByLibrary.simpleMessage("Daily champion"),
    "AchFirstWin": MessageLookupByLibrary.simpleMessage("First victory"),
    "AchGames10": MessageLookupByLibrary.simpleMessage("10 games played"),
    "AchGames50": MessageLookupByLibrary.simpleMessage("50 games played"),
    "AchPerfectGame": MessageLookupByLibrary.simpleMessage("Perfect game"),
    "AchWinHard": MessageLookupByLibrary.simpleMessage("Hard mode win"),
    "AchWinStreak3": MessageLookupByLibrary.simpleMessage("3-win streak"),
    "AchWinStreak5": MessageLookupByLibrary.simpleMessage("5-win streak"),
    "AchievementGamesProgress": m0,
    "AchievementStreakProgress": m1,
    "AchievementUnlocked": MessageLookupByLibrary.simpleMessage(
      "Achievement unlocked",
    ),
    "AchievementWinsProgress": m2,
    "Achievements": MessageLookupByLibrary.simpleMessage("Achievements"),
    "AdFailed": MessageLookupByLibrary.simpleMessage(
      "Ad unavailable. Please try again later.",
    ),
    "AdLoading": MessageLookupByLibrary.simpleMessage("Loading ad…"),
    "AdsRemoved": MessageLookupByLibrary.simpleMessage("Ads removed"),
    "AgainstComputer": MessageLookupByLibrary.simpleMessage("Computer"),
    "BestStreak": MessageLookupByLibrary.simpleMessage("Best streak"),
    "Black": MessageLookupByLibrary.simpleMessage("Black"),
    "BlackWins": MessageLookupByLibrary.simpleMessage("Black wins"),
    "BoardCell": m3,
    "BoardEmpty": MessageLookupByLibrary.simpleMessage("Empty"),
    "BoardKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Use arrow keys to explore the board and Enter or Space to play a marked square.",
    ),
    "BoardLastMove": MessageLookupByLibrary.simpleMessage("Last move"),
    "BoardLegalMove": MessageLookupByLibrary.simpleMessage("Legal move"),
    "BoardReviewKeyboardHint": MessageLookupByLibrary.simpleMessage(
      "Use arrow keys to explore the board.",
    ),
    "Cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
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
    "Classical_Music_Box": MessageLookupByLibrary.simpleMessage(
      "Classical Music Box",
    ),
    "CoachAllowsCorner": MessageLookupByLibrary.simpleMessage(
      "Your opponent can capture a corner on the next turn.",
    ),
    "CoachAnalyzing": MessageLookupByLibrary.simpleMessage(
      "Looking for a useful position to explore…",
    ),
    "CoachAvoidCorner": MessageLookupByLibrary.simpleMessage(
      "Another legal move gives your opponent an immediate corner capture. This move avoids that threat.",
    ),
    "CoachComparison": m4,
    "CoachCorner": MessageLookupByLibrary.simpleMessage(
      "This move claims a corner. A corner disc cannot be flipped.",
    ),
    "CoachEndsGame": MessageLookupByLibrary.simpleMessage(
      "Neither side can move after this play. The game ends.",
    ),
    "CoachForPlayer": m5,
    "CoachJump": MessageLookupByLibrary.simpleMessage("Go to this position"),
    "CoachMatched": m6,
    "CoachNoPosition": MessageLookupByLibrary.simpleMessage(
      "There are no playable positions to explore in this game.",
    ),
    "CoachPass": MessageLookupByLibrary.simpleMessage(
      "Your opponent has no legal reply, so you play again.",
    ),
    "CoachPositionTitle": MessageLookupByLibrary.simpleMessage(
      "Explore this position",
    ),
    "CoachPractice": MessageLookupByLibrary.simpleMessage("Try this position"),
    "CoachReplies": m7,
    "CoachScope": MessageLookupByLibrary.simpleMessage(
      "A short search suggests ideas to explore; it does not guarantee the strongest move.",
    ),
    "CoachShareResult": MessageLookupByLibrary.simpleMessage("Share result"),
    "CoachSuggested": m8,
    "CoachTitle": MessageLookupByLibrary.simpleMessage("Strategy coach"),
    "CoachTurnTitle": MessageLookupByLibrary.simpleMessage(
      "A position worth revisiting",
    ),
    "CoachUnavailable": MessageLookupByLibrary.simpleMessage(
      "Coaching is unavailable right now. You can still replay every move.",
    ),
    "ComputerColor": m9,
    "ComputerThinking": MessageLookupByLibrary.simpleMessage(
      "Computer is thinking…",
    ),
    "ContinueGame": MessageLookupByLibrary.simpleMessage("Continue game"),
    "Crazy_Pyramid": MessageLookupByLibrary.simpleMessage("Crazy Pyramid"),
    "CurrentStreak": MessageLookupByLibrary.simpleMessage("Win streak"),
    "Cute_Animal_Merge": MessageLookupByLibrary.simpleMessage(
      "Cute Animal Merge",
    ),
    "DailyChallenge": MessageLookupByLibrary.simpleMessage("Daily Challenge"),
    "DailyChallengeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Beat today\'s puzzle on Hard",
    ),
    "DailyCompleted": MessageLookupByLibrary.simpleMessage(
      "Completed today — play again for fun",
    ),
    "DailyCompletions": MessageLookupByLibrary.simpleMessage(
      "Daily challenges completed",
    ),
    "Delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "DeleteSavedMatch": MessageLookupByLibrary.simpleMessage("Delete match"),
    "DeleteSavedMatchMessage": MessageLookupByLibrary.simpleMessage(
      "This replay will be removed from your library. Your statistics will stay the same.",
    ),
    "DeleteSavedMatchTitle": MessageLookupByLibrary.simpleMessage(
      "Delete this match?",
    ),
    "Difficulty": MessageLookupByLibrary.simpleMessage("Difficulty"),
    "DifficultyEasy": MessageLookupByLibrary.simpleMessage("Easy"),
    "DifficultyHard": MessageLookupByLibrary.simpleMessage("Hard"),
    "DifficultyMedium": MessageLookupByLibrary.simpleMessage("Medium"),
    "DifficultySuperEasy": MessageLookupByLibrary.simpleMessage("Super Easy"),
    "FeedbackBalanced": MessageLookupByLibrary.simpleMessage("Balanced"),
    "FeedbackGentle": MessageLookupByLibrary.simpleMessage("Gentle"),
    "FeedbackIntensity": MessageLookupByLibrary.simpleMessage(
      "Feedback intensity",
    ),
    "FeedbackLively": MessageLookupByLibrary.simpleMessage("Lively"),
    "FirstPlayerComputer": MessageLookupByLibrary.simpleMessage("Computer"),
    "FirstPlayerHuman": MessageLookupByLibrary.simpleMessage("Player"),
    "FirstPlayerRandom": MessageLookupByLibrary.simpleMessage("Random"),
    "Flappy_Fish": MessageLookupByLibrary.simpleMessage("Flappy Fish"),
    "Fling_Knife": MessageLookupByLibrary.simpleMessage("Fling Knife"),
    "GameOver": MessageLookupByLibrary.simpleMessage("Game Over"),
    "GameSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Your game could not be saved. Please try again before leaving.",
    ),
    "GameSetup": MessageLookupByLibrary.simpleMessage("Set up your game"),
    "GameStatusAnnouncement": m10,
    "GamesPlayed": MessageLookupByLibrary.simpleMessage("Games played"),
    "Garden_Catch_Bugs": MessageLookupByLibrary.simpleMessage(
      "Garden: Catch Bugs",
    ),
    "GuidedFirstGame": MessageLookupByLibrary.simpleMessage(
      "Learn with a guided game",
    ),
    "GuidedFirstGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Practice a capture, discover corners, and find your rhythm.",
    ),
    "Haptics": MessageLookupByLibrary.simpleMessage("Haptics"),
    "Help": MessageLookupByLibrary.simpleMessage("Help"),
    "Hint": MessageLookupByLibrary.simpleMessage("Hint"),
    "HintWithAd": MessageLookupByLibrary.simpleMessage(
      "Legal moves · watch an ad",
    ),
    "HintsEnabled": MessageLookupByLibrary.simpleMessage(
      "Hints enabled for this game.",
    ),
    "Home": MessageLookupByLibrary.simpleMessage("Home"),
    "HomeTagline": MessageLookupByLibrary.simpleMessage(
      "A little strategy. A moment for yourself.",
    ),
    "HowToControlsBody": MessageLookupByLibrary.simpleMessage(
      "Undo returns to the position before your last move. Hint highlights legal squares. Restart begins the same game setup again. Settings changes sound, haptics, and theme. Home returns to the beginning screen.",
    ),
    "HowToControlsTitle": MessageLookupByLibrary.simpleMessage("Game controls"),
    "HowToLearnMore": MessageLookupByLibrary.simpleMessage(
      "Rules, controls, strategy tips, and app instructions",
    ),
    "HowToMoveBody": MessageLookupByLibrary.simpleMessage(
      "Place a disk on an empty square so that one or more opposing disks are trapped in a straight horizontal, vertical, or diagonal line between your new disk and another one of your disks. All trapped disks flip to your color.",
    ),
    "HowToMoveTitle": MessageLookupByLibrary.simpleMessage("Make a move"),
    "HowToTipsBody": MessageLookupByLibrary.simpleMessage(
      "Corners can never be flipped, so work toward them carefully. Avoid giving away squares beside an open corner. Mobility matters: try to keep several legal moves available while limiting your opponent\'s choices.",
    ),
    "HowToTipsTitle": MessageLookupByLibrary.simpleMessage("Strategy tips"),
    "HowToTurnsBody": MessageLookupByLibrary.simpleMessage(
      "Black moves first. If a player has no legal move, their turn is passed automatically. The game continues until neither player can move.",
    ),
    "HowToTurnsTitle": MessageLookupByLibrary.simpleMessage("Take turns"),
    "HowToWinBody": MessageLookupByLibrary.simpleMessage(
      "The game ends when the board is full or neither side has a legal move. The player with more disks on the board wins.",
    ),
    "HowToWinTitle": MessageLookupByLibrary.simpleMessage(
      "Finish with the most disks",
    ),
    "How_to_play": MessageLookupByLibrary.simpleMessage("How to play?"),
    "How_to_play_explain": MessageLookupByLibrary.simpleMessage(
      "In the game, any disks of the opponent\'s color that are in a straight line and bounded by the disk just placed and another disk of the current player\'s color are turned over to the current player\'s color. The objective of the game is to have the majority of disks turned to display one\'s color when the last playable empty square is filled.",
    ),
    "Image_Guru": MessageLookupByLibrary.simpleMessage("Image Guru"),
    "Instant_Face": MessageLookupByLibrary.simpleMessage("Instant Face"),
    "KeepPlaying": MessageLookupByLibrary.simpleMessage("Keep playing"),
    "Losses": MessageLookupByLibrary.simpleMessage("Losses"),
    "MatchLibrary": MessageLookupByLibrary.simpleMessage("Match library"),
    "MatchLibraryDeleteError": MessageLookupByLibrary.simpleMessage(
      "This match could not be deleted. Please try again.",
    ),
    "MatchLibraryEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Finish a game and it will appear here. Revisit every move and discover what to try next.",
    ),
    "MatchLibraryEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Your story starts here",
    ),
    "MatchLibraryLoadError": MessageLookupByLibrary.simpleMessage(
      "Your match library could not be loaded.",
    ),
    "MatchLibraryOpen": MessageLookupByLibrary.simpleMessage("Review match"),
    "MatchLibrarySaveError": MessageLookupByLibrary.simpleMessage(
      "This game could not be saved to your match library.",
    ),
    "MatchLibrarySubtitle": MessageLookupByLibrary.simpleMessage(
      "Your last 100 completed games, ready to replay.",
    ),
    "MilestoneCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "Mint_Translate": MessageLookupByLibrary.simpleMessage("Mint Translate"),
    "Money_Tracker": MessageLookupByLibrary.simpleMessage("Money Tracker"),
    "More": MessageLookupByLibrary.simpleMessage("More"),
    "MoreApps": MessageLookupByLibrary.simpleMessage("More Apps"),
    "MoreAppsUnavailable": MessageLookupByLibrary.simpleMessage(
      "More apps are available in the iOS and Android versions.",
    ),
    "NewGame": MessageLookupByLibrary.simpleMessage("New game"),
    "NextMilestone": MessageLookupByLibrary.simpleMessage("Next milestone"),
    "Novels_Hub": MessageLookupByLibrary.simpleMessage("Novels Hub"),
    "OK": MessageLookupByLibrary.simpleMessage("OK"),
    "Opponent": MessageLookupByLibrary.simpleMessage("Opponent"),
    "PerfectWins": MessageLookupByLibrary.simpleMessage("Perfect wins"),
    "Play": MessageLookupByLibrary.simpleMessage("Play"),
    "PlayAgainstFriend": MessageLookupByLibrary.simpleMessage(
      "Play against a friend on this device",
    ),
    "PlayerTurn": m11,
    "PracticeBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Strategy practice board",
    ),
    "PracticeFlipped": m12,
    "PracticeInstructions": MessageLookupByLibrary.simpleMessage(
      "Play any marked square and inspect what changes.",
    ),
    "PracticeNoMoves": MessageLookupByLibrary.simpleMessage(
      "This side has no legal move in this position.",
    ),
    "PracticePlayed": m13,
    "PracticeReset": MessageLookupByLibrary.simpleMessage("Try another move"),
    "PracticeSafe": MessageLookupByLibrary.simpleMessage(
      "Practice is separate from your saved game and statistics.",
    ),
    "PracticeTitle": MessageLookupByLibrary.simpleMessage("Try this position"),
    "PrivacyOptions": MessageLookupByLibrary.simpleMessage("Privacy options"),
    "PrivacyOptionsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Update your ad privacy choices",
    ),
    "PrivacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "PrivacyPolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "How we handle data and ads",
    ),
    "PurchaseAlreadyOwned": MessageLookupByLibrary.simpleMessage(
      "You already own Remove Ads.",
    ),
    "PurchaseBenefitAds": MessageLookupByLibrary.simpleMessage(
      "No banner or app-open ads.",
    ),
    "PurchaseBenefitHints": MessageLookupByLibrary.simpleMessage(
      "Legal-move hints on every computer difficulty without watching an ad.",
    ),
    "PurchaseBenefitOnce": MessageLookupByLibrary.simpleMessage(
      "One payment. No subscription. Restore with your App Store account.",
    ),
    "PurchaseBenefitUndo": MessageLookupByLibrary.simpleMessage(
      "Undo once per turn on Hard without watching an ad.",
    ),
    "PurchaseBenefits": MessageLookupByLibrary.simpleMessage(
      "A one-time purchase removes banner and app-open ads and unlocks Hard-mode undo and legal-move hints without rewarded ads. Restore it on devices using the same App Store account.",
    ),
    "PurchaseCancelled": MessageLookupByLibrary.simpleMessage(
      "Purchase cancelled.",
    ),
    "PurchaseFailed": MessageLookupByLibrary.simpleMessage(
      "Purchase failed. Please try again.",
    ),
    "PurchasePending": MessageLookupByLibrary.simpleMessage(
      "Purchase pending approval…",
    ),
    "PurchaseSettingsSubtitle": MessageLookupByLibrary.simpleMessage(
      "See purchase benefits or restore an existing purchase",
    ),
    "PurchaseSuccess": MessageLookupByLibrary.simpleMessage(
      "Ads have been removed. Thank you!",
    ),
    "PurchaseUnavailable": MessageLookupByLibrary.simpleMessage(
      "Purchases are currently unavailable.",
    ),
    "PuzzleAllComplete": MessageLookupByLibrary.simpleMessage(
      "All nine puzzles solved. Revisit any position to sharpen your play.",
    ),
    "PuzzleBackToArchive": MessageLookupByLibrary.simpleMessage(
      "Back to puzzles",
    ),
    "PuzzleBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Practice puzzle board",
    ),
    "PuzzleCompleted": MessageLookupByLibrary.simpleMessage("Solved"),
    "PuzzleCompletionSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Progress could not be saved. Keep this screen open and try again.",
    ),
    "PuzzleCornerDescription": MessageLookupByLibrary.simpleMessage(
      "Spot a safe corner and close the capture line.",
    ),
    "PuzzleCornerHintOne": MessageLookupByLibrary.simpleMessage(
      "Corner discs cannot be flipped. Look for a line you can close.",
    ),
    "PuzzleCornerHintTwo": MessageLookupByLibrary.simpleMessage(
      "Trace inward from the target corner until your own disc brackets the opponent.",
    ),
    "PuzzleCornerObjective": m14,
    "PuzzleCornerSkill": MessageLookupByLibrary.simpleMessage("Claim a corner"),
    "PuzzleCornerSuccess": MessageLookupByLibrary.simpleMessage(
      "Corner secured. A corner disc stays yours for the rest of the game.",
    ),
    "PuzzleEndgameDescription": MessageLookupByLibrary.simpleMessage(
      "Play the final moves against the best replies.",
    ),
    "PuzzleEndgameHintOne": MessageLookupByLibrary.simpleMessage(
      "The final disc count decides the winner. Count through to the end.",
    ),
    "PuzzleEndgameHintTwo": MessageLookupByLibrary.simpleMessage(
      "Compare the opponent’s replies. A smaller capture may keep the last move.",
    ),
    "PuzzleEndgameObjective": m15,
    "PuzzleEndgameSkill": MessageLookupByLibrary.simpleMessage(
      "Finish with a win",
    ),
    "PuzzleEndgameSuccess": MessageLookupByLibrary.simpleMessage(
      "Endgame won. Your choices held up against the best replies.",
    ),
    "PuzzleEndgameTryAgain": MessageLookupByLibrary.simpleMessage(
      "This line cannot force a win against best play. Restart and compare another move.",
    ),
    "PuzzleHint": m16,
    "PuzzleHintCoordinate": m17,
    "PuzzleNext": MessageLookupByLibrary.simpleMessage("Next puzzle"),
    "PuzzleNoResults": MessageLookupByLibrary.simpleMessage(
      "No matching puzzles. Try a skill or puzzle number.",
    ),
    "PuzzleNumber": m18,
    "PuzzleOpponentThinking": MessageLookupByLibrary.simpleMessage(
      "Considering the best reply…",
    ),
    "PuzzlePassDescription": MessageLookupByLibrary.simpleMessage(
      "Leave your opponent without a legal move.",
    ),
    "PuzzlePassHintOne": MessageLookupByLibrary.simpleMessage(
      "A pass happens only when the opponent has no legal move.",
    ),
    "PuzzlePassHintTwo": MessageLookupByLibrary.simpleMessage(
      "Compare the opponent’s available moves after each candidate.",
    ),
    "PuzzlePassObjective": m19,
    "PuzzlePassSkill": MessageLookupByLibrary.simpleMessage(
      "Earn another turn",
    ),
    "PuzzlePassSuccess": MessageLookupByLibrary.simpleMessage(
      "You earned another turn. Your opponent has no legal move, and the game continues.",
    ),
    "PuzzleProgress": m20,
    "PuzzleProgressLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Puzzle progress could not be loaded. Try again.",
    ),
    "PuzzleRestart": MessageLookupByLibrary.simpleMessage("Restart puzzle"),
    "PuzzleRevealHint": MessageLookupByLibrary.simpleMessage("Reveal a hint"),
    "PuzzleSaveProgress": MessageLookupByLibrary.simpleMessage("Save progress"),
    "PuzzleSearch": MessageLookupByLibrary.simpleMessage("Search puzzles"),
    "PuzzleTryAgain": MessageLookupByLibrary.simpleMessage(
      "That move does not solve this position. Restart and try another line.",
    ),
    "PuzzleYourMove": MessageLookupByLibrary.simpleMessage("Your move"),
    "Puzzles": MessageLookupByLibrary.simpleMessage("Practice puzzles"),
    "PuzzlesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Nine carefully chosen positions. Build one skill at a time.",
    ),
    "ReduceMotion": MessageLookupByLibrary.simpleMessage("Reduce motion"),
    "ReduceMotionSubtitle": MessageLookupByLibrary.simpleMessage(
      "Minimizes piece movement and celebration effects",
    ),
    "Relaxing_Up": MessageLookupByLibrary.simpleMessage("Relaxing Up"),
    "Rematch": MessageLookupByLibrary.simpleMessage("Rematch"),
    "RemoveAds": MessageLookupByLibrary.simpleMessage("Remove Ads"),
    "ReplaceSavedGameMessage": MessageLookupByLibrary.simpleMessage(
      "Your unfinished game will be replaced. You can continue it from Home instead.",
    ),
    "ReplaceSavedGameTitle": MessageLookupByLibrary.simpleMessage(
      "Start a new game?",
    ),
    "RestartConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "Your current board will be replaced by the starting position.",
    ),
    "RestartConfirmTitle": MessageLookupByLibrary.simpleMessage(
      "Restart this game?",
    ),
    "RestartGame": MessageLookupByLibrary.simpleMessage("Restart game"),
    "RestoreNothing": MessageLookupByLibrary.simpleMessage(
      "No purchases to restore.",
    ),
    "RestorePurchaseHelp": MessageLookupByLibrary.simpleMessage(
      "Already purchased? Restore it from your App Store account.",
    ),
    "RestorePurchases": MessageLookupByLibrary.simpleMessage(
      "Restore Purchases",
    ),
    "RestoreSuccess": MessageLookupByLibrary.simpleMessage(
      "Purchases restored.",
    ),
    "ResultCardError": MessageLookupByLibrary.simpleMessage(
      "Your result card could not be created.",
    ),
    "ResultCardPreparing": MessageLookupByLibrary.simpleMessage(
      "Creating your result card…",
    ),
    "ResultCardPreviewLabel": m21,
    "ResultCardShareFailed": MessageLookupByLibrary.simpleMessage(
      "Sharing is unavailable right now. Please try again.",
    ),
    "ResultCardTitle": MessageLookupByLibrary.simpleMessage(
      "Share your result",
    ),
    "ReviewBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Game review board",
    ),
    "ReviewCorners": m22,
    "ReviewFinal": MessageLookupByLibrary.simpleMessage("Final position"),
    "ReviewFirst": MessageLookupByLibrary.simpleMessage("Go to start"),
    "ReviewGame": MessageLookupByLibrary.simpleMessage("Review game"),
    "ReviewLast": MessageLookupByLibrary.simpleMessage("Go to end"),
    "ReviewMove": m23,
    "ReviewNext": MessageLookupByLibrary.simpleMessage("Next move"),
    "ReviewPrevious": MessageLookupByLibrary.simpleMessage("Previous move"),
    "ReviewStart": MessageLookupByLibrary.simpleMessage("Starting position"),
    "Rules": MessageLookupByLibrary.simpleMessage("Rules"),
    "SavedGameSubtitle": MessageLookupByLibrary.simpleMessage(
      "Your board is ready when you are.",
    ),
    "SavedMatchScore": m24,
    "Saving_Ambulance": MessageLookupByLibrary.simpleMessage(
      "Saving Ambulance",
    ),
    "Settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "Share": MessageLookupByLibrary.simpleMessage("Share"),
    "ShareResult": m25,
    "Simple_Calculator": MessageLookupByLibrary.simpleMessage(
      "Simple Calculator",
    ),
    "Solitaire_Guru": MessageLookupByLibrary.simpleMessage("Solitaire Guru"),
    "Sound": MessageLookupByLibrary.simpleMessage("Sound"),
    "Space_Jumper": MessageLookupByLibrary.simpleMessage("Space Jumper"),
    "StartGame": MessageLookupByLibrary.simpleMessage("Start Game"),
    "StartNewGame": MessageLookupByLibrary.simpleMessage("Start new game"),
    "Stats": MessageLookupByLibrary.simpleMessage("Stats"),
    "Sudoku_Lover": MessageLookupByLibrary.simpleMessage("Sudoku Lover"),
    "Theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "ThemeClassic": MessageLookupByLibrary.simpleMessage("Classic"),
    "ThemeContrast": MessageLookupByLibrary.simpleMessage("Contrast"),
    "ThemeNight": MessageLookupByLibrary.simpleMessage("Night"),
    "Tie": MessageLookupByLibrary.simpleMessage("Tie"),
    "Ties": MessageLookupByLibrary.simpleMessage("Ties"),
    "TryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
    "TurnPassed": m26,
    "TutorialBoardLabel": MessageLookupByLibrary.simpleMessage(
      "Practice board",
    ),
    "TutorialCaptureBody": MessageLookupByLibrary.simpleMessage(
      "You are Black. Tap a marked square to trap a white disc between two black discs.",
    ),
    "TutorialCaptureDoneBody": MessageLookupByLibrary.simpleMessage(
      "The trapped white disc turns black. White replies next, then it is your turn again.",
    ),
    "TutorialCaptureDoneTitle": MessageLookupByLibrary.simpleMessage(
      "That is a capture",
    ),
    "TutorialCaptureTitle": MessageLookupByLibrary.simpleMessage(
      "Make your first capture",
    ),
    "TutorialCompleteBody": MessageLookupByLibrary.simpleMessage(
      "Win by finishing with more discs. If you have no legal move, your turn passes automatically. Start with Easy and move up when you feel ready.",
    ),
    "TutorialCompleteTitle": MessageLookupByLibrary.simpleMessage(
      "You are ready",
    ),
    "TutorialCornersBody": MessageLookupByLibrary.simpleMessage(
      "Try this practice position. Tap the marked corner at A1. A corner disc cannot be flipped.",
    ),
    "TutorialCornersTitle": MessageLookupByLibrary.simpleMessage(
      "Claim a corner",
    ),
    "TutorialNext": MessageLookupByLibrary.simpleMessage("Continue"),
    "TutorialPlayEasy": MessageLookupByLibrary.simpleMessage(
      "Play an Easy game",
    ),
    "TutorialProgress": m27,
    "TutorialReplyBody": MessageLookupByLibrary.simpleMessage(
      "White has played. Tap any marked square to make another capture.",
    ),
    "TutorialReplyDoneBody": MessageLookupByLibrary.simpleMessage(
      "You have played a full turn. Now try a corner in a practice position.",
    ),
    "TutorialSkip": MessageLookupByLibrary.simpleMessage("Skip tutorial"),
    "TutorialTitle": MessageLookupByLibrary.simpleMessage("Learn by playing"),
    "TwoPlayersMode": MessageLookupByLibrary.simpleMessage(
      "2 Players (pass & play)",
    ),
    "Undo": MessageLookupByLibrary.simpleMessage("Undo"),
    "UndoWithAd": MessageLookupByLibrary.simpleMessage("Undo · watch an ad"),
    "Watch": MessageLookupByLibrary.simpleMessage("Watch"),
    "WatchAd": MessageLookupByLibrary.simpleMessage("Watch Ad"),
    "WatchAdForHint": MessageLookupByLibrary.simpleMessage(
      "Watch a short ad to show legal moves for this game.",
    ),
    "WatchAdForUndo": MessageLookupByLibrary.simpleMessage(
      "Watch a short ad to undo your last move.",
    ),
    "We_Play_Piano": MessageLookupByLibrary.simpleMessage("We Play Piano"),
    "White": MessageLookupByLibrary.simpleMessage("White"),
    "WhiteWins": MessageLookupByLibrary.simpleMessage("White wins"),
    "WhoGoesFirst": MessageLookupByLibrary.simpleMessage("Who goes first?"),
    "WinRate": MessageLookupByLibrary.simpleMessage("Win rate"),
    "Wins": MessageLookupByLibrary.simpleMessage("Wins"),
    "WinsByDifficulty": MessageLookupByLibrary.simpleMessage(
      "Wins by difficulty",
    ),
    "WinsLosses": m28,
    "World_Weather_Live": MessageLookupByLibrary.simpleMessage(
      "World Weather Live",
    ),
    "Yes_Habit": MessageLookupByLibrary.simpleMessage("Yes Habit"),
    "YouColor": m29,
    "YouLose": MessageLookupByLibrary.simpleMessage("You lose"),
    "YouWin": MessageLookupByLibrary.simpleMessage("You win!"),
    "YourTurn": MessageLookupByLibrary.simpleMessage("Your turn"),
    "falling_block_puzzle": MessageLookupByLibrary.simpleMessage(
      "Falling Block Puzzle",
    ),
  };
}
