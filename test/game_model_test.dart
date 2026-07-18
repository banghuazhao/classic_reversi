import 'package:flutter_test/flutter_test.dart';

import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/game_settings.dart';
import 'package:classic_reversi/move_finder.dart';

void main() {
  test('invalid moves return null instead of throwing', () {
    final model = GameModel(board: GameBoard());

    expect(model.updateForMove(0, 0), isNull);
  });

  test('super easy starts on a valid 6 by 6 board', () {
    final model = GameModel.initial(boardSize: Difficulty.superEasy.boardSize);

    expect(model.board.width, 6);
    expect(model.board.height, 6);
    expect(model.blackScore, 2);
    expect(model.whiteScore, 2);
    expect(model.board.getMovesForPlayer(PieceType.black), hasLength(4));
  });

  test('super easy AI always returns a legal move', () async {
    final board = GameBoard(size: GameBoard.compactSize);
    final move = await MoveFinder(board).findMove(
      PieceType.black,
      Difficulty.superEasy,
    );

    expect(move, isNotNull);
    expect(board.isLegalMove(move!.x, move.y, PieceType.black), isTrue);
  });
}
