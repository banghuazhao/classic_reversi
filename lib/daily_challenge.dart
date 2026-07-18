import 'dart:math';

import 'game_board.dart';
import 'game_settings.dart';
import 'settings_service.dart';

/// Builds a deterministic mid-game position for "today" so every player
/// gets the same Daily Challenge.
class DailyChallenge {
  const DailyChallenge._();

  static int seedForDate(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    return day.year * 10000 + day.month * 100 + day.day;
  }

  /// Returns a mid-game board and whose turn it is.
  static ({GameBoard board, PieceType player}) generate([DateTime? date]) {
    final now = date ?? DateTime.now();
    final rng = Random(seedForDate(now));
    var board = GameBoard();
    var player = PieceType.black;

    // Advance the opening into a mid-game position with enough life left.
    final targetMoves = 18 + rng.nextInt(17); // 18–34 plies
    var movesMade = 0;
    var safety = 0;

    while (movesMade < targetMoves && safety < 80) {
      safety++;
      var legal = board.getMovesForPlayer(player);
      if (legal.isEmpty) {
        player = getOpponent(player);
        legal = board.getMovesForPlayer(player);
        if (legal.isEmpty) {
          break;
        }
      }
      final move = legal[rng.nextInt(legal.length)];
      board = board.updateForMove(move.x, move.y, player);
      movesMade++;
      final opponent = getOpponent(player);
      if (board.getMovesForPlayer(opponent).isNotEmpty) {
        player = opponent;
      }
    }

    // Prefer a position where Black (human) can move.
    if (board.getMovesForPlayer(PieceType.black).isEmpty &&
        board.getMovesForPlayer(PieceType.white).isNotEmpty) {
      player = PieceType.white;
    } else if (board.getMovesForPlayer(PieceType.black).isNotEmpty) {
      player = PieceType.black;
    }

    // Fallback: if somehow the game is dead, use a shallow opening.
    if (board.getMovesForPlayer(PieceType.black).isEmpty &&
        board.getMovesForPlayer(PieceType.white).isEmpty) {
      board = GameBoard();
      player = PieceType.black;
    }

    return (board: board, player: player);
  }

  static GameSettings settingsForToday([DateTime? date]) {
    final generated = generate(date);
    return GameSettings(
      difficulty: Difficulty.hard,
      twoPlayerMode: false,
      humanColor: PieceType.black,
      isDailyChallenge: true,
      initialBoard: generated.board,
      initialPlayer: generated.player,
    );
  }

  static Future<bool> isCompletedToday() =>
      SettingsService.isDailyCompletedToday();
}
