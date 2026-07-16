import 'package:flutter_test/flutter_test.dart';

import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_model.dart';

void main() {
  test('invalid moves return null instead of throwing', () {
    final model = GameModel(board: GameBoard());

    expect(model.updateForMove(0, 0), isNull);
  });
}
