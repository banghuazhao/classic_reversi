import 'package:classic_reversi/game_board.dart';
import 'package:classic_reversi/game_model.dart';
import 'package:classic_reversi/strategy_coach.dart';
import 'package:flutter_test/flutter_test.dart';

GameModel _position(List<List<int>> rows,
        {PieceType player = PieceType.black}) =>
    GameModel(
        board: GameBoard.fromRows(rows
            .map((row) => row.map((p) => PieceType.values[p]).toList())
            .toList()),
        player: player);

bool _corner(GameBoard board, Position move) =>
    (move.x == 0 || move.x == board.size - 1) &&
    (move.y == 0 || move.y == board.size - 1);

void main() {
  test('suggestions are legal, deterministic, and leave the board intact',
      () async {
    final position = GameModel.initial();
    final original = position.board.rows.map((row) => row.toList()).toList();
    final first = (await StrategyCoach.analyze(position))!;
    final second = (await StrategyCoach.analyze(position))!;
    expect(
        position.board.isLegalMove(first.move.x, first.move.y, position.player),
        isTrue);
    expect(StrategyCoach.sameMove(first.move, second.move), isTrue);
    expect(first.score, second.score);
    expect(first.reasons, second.reasons);
    expect(position.board.rows, original);
    expect(
        first.opponentReplies,
        position
            .updateForMove(first.move.x, first.move.y)!
            .board
            .getMovesForPlayer(PieceType.white)
            .length);
  });

  test(
      'corner, mobility, and risk explanations describe the actual resulting board',
      () async {
    final position = _position([
      [0, 2, 1, 0, 0, 0],
      [2, 2, 1, 2, 0, 0],
      [1, 2, 2, 1, 0, 0],
      [0, 1, 2, 1, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
    ]);
    final corner = (await StrategyCoach.analyze(position,
        chosenMove: const Position(0, 0)))!;
    expect(corner.reasons, contains(StrategyReason.corner));
    final legal = position.board.getMovesForPlayer(position.player);
    for (final move in legal) {
      final advice = (await StrategyCoach.analyze(position, chosenMove: move))!;
      final after = position.updateForMove(move.x, move.y)!;
      final replies = after.board.getMovesForPlayer(PieceType.white);
      expect(advice.opponentReplies, replies.length);
      expect(advice.reasons.contains(StrategyReason.corner),
          _corner(position.board, move));
      expect(advice.reasons.contains(StrategyReason.allowsCorner),
          replies.any((p) => _corner(after.board, p)));
      if (advice.reasons.contains(StrategyReason.avoidsCorner)) {
        expect(replies.any((p) => _corner(after.board, p)), isFalse);
        expect(legal.any((alternative) {
          final board = position.board
              .updateForMove(alternative.x, alternative.y, position.player);
          return board
              .getMovesForPlayer(PieceType.white)
              .any((p) => _corner(board, p));
        }), isTrue);
      }
    }
  });

  test('a forced pass is distinct from finishing the game', () async {
    final position = _position([
      [0, 2, 2, 1],
      [0, 2, 2, 1],
      [2, 2, 2, 2],
      [1, 1, 0, 0],
    ]);
    final advice = (await StrategyCoach.analyze(position,
        chosenMove: const Position(3, 3)))!;
    final after = position.updateForMove(3, 3)!;
    expect(after.player, PieceType.black);
    expect(after.board.getMovesForPlayer(PieceType.white), isEmpty);
    expect(after.board.getMovesForPlayer(PieceType.black), isNotEmpty);
    expect(advice.reasons, contains(StrategyReason.forcesPass));
    expect(advice.reasons, isNot(contains(StrategyReason.endsGame)));

    final end = _position([
      [1, 1, 1, 1],
      [1, 1, 1, 1],
      [1, 1, 1, 1],
      [0, 2, 1, 1],
    ]);
    final finalAdvice = (await StrategyCoach.analyze(end))!;
    expect(finalAdvice.reasons, contains(StrategyReason.endsGame));
    expect(finalAdvice.reasons, isNot(contains(StrategyReason.forcesPass)));
    expect(
        end.updateForMove(finalAdvice.move.x, finalAdvice.move.y)!.gameIsOver,
        isTrue);
  });

  test('no legal moves and illegal requested alternatives return no advice',
      () async {
    final terminal = _position(List.generate(4, (_) => List.filled(4, 1)),
        player: PieceType.empty);
    expect(await StrategyCoach.analyze(terminal), isNull);
    expect(
        await StrategyCoach.analyze(GameModel.initial(),
            chosenMove: const Position(0, 0)),
        isNull);
    expect(await StrategyCoach.findTurningPoint([terminal]), isNull);
  });

  test(
      'turning point belongs to chronology and respects the human color filter',
      () async {
    final first = GameModel.initial(boardSize: 4);
    final suggestion = (await StrategyCoach.analyze(first))!;
    final alternative = first.board
        .getMovesForPlayer(first.player)
        .firstWhere((p) => !StrategyCoach.sameMove(p, suggestion.move));
    final next = first.updateForMove(alternative.x, alternative.y)!;
    final reply = next.board.getMovesForPlayer(next.player).first;
    final history = [first, next, next.updateForMove(reply.x, reply.y)!];
    final point = (await StrategyCoach.findTurningPoint(history,
        player: PieceType.black))!;
    expect(point.index, 0);
    expect(StrategyCoach.sameMove(point.actualMove, alternative), isTrue);
    expect(point.offersAlternative, isTrue);
    expect(
        first.board.isLegalMove(
            point.advice.move.x, point.advice.move.y, first.player),
        isTrue);
    final white = (await StrategyCoach.findTurningPoint(history,
        player: PieceType.white))!;
    expect(white.index, 1);
    expect(white.advice.player, PieceType.white);
  });
}
