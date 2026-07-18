import 'package:flutter_test/flutter_test.dart';

import 'package:classic_reversi/daily_challenge.dart';
import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_settings.dart';

void main() {
  test('daily challenge is deterministic for a given date', () {
    final date = DateTime(2026, 7, 18);
    final a = DailyChallenge.generate(date);
    final b = DailyChallenge.generate(date);

    expect(a.player, b.player);
    for (var y = 0; y < a.board.height; y++) {
      for (var x = 0; x < a.board.width; x++) {
        expect(
          a.board.getPieceAtLocation(x, y),
          b.board.getPieceAtLocation(x, y),
        );
      }
    }
  });

  test('daily challenge settings use hard single-player as black', () {
    final settings = DailyChallenge.settingsForToday(DateTime(2026, 1, 1));
    expect(settings.isDailyChallenge, isTrue);
    expect(settings.difficulty, Difficulty.hard);
    expect(settings.twoPlayerMode, isFalse);
    expect(settings.humanColor, PieceType.black);
    expect(settings.initialBoard, isNotNull);
  });

  test('generated position still has legal moves', () {
    final generated = DailyChallenge.generate(DateTime(2026, 3, 15));
    final blackMoves = generated.board.getMovesForPlayer(PieceType.black);
    final whiteMoves = generated.board.getMovesForPlayer(PieceType.white);
    expect(blackMoves.isNotEmpty || whiteMoves.isNotEmpty, isTrue);
  });
}
