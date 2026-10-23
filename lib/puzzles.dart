import 'game_board.dart';
import 'game_model.dart';

enum PuzzleSkill { corner, forcedPass, endgame }

String puzzleCoordinate(Position move) =>
    '${String.fromCharCode(65 + move.x)}${move.y + 1}';

Position puzzlePosition(String coordinate) => Position(
      coordinate.codeUnitAt(0) - 65,
      int.parse(coordinate.substring(1)) - 1,
    );

/// A frozen position reached by the legal [openingLine] from a normal 6×6
/// opening. Solutions are explicit and independently verified by the rules.
class ReversiPuzzle {
  const ReversiPuzzle({
    required this.id,
    required this.number,
    required this.skill,
    required this.position,
    required this.player,
    required this.openingLine,
    required this.solutionCoordinates,
    this.targetCorner,
  });

  final String id;
  final int number;
  final PuzzleSkill skill;
  final String position;
  final PieceType player;
  final String openingLine;
  final List<String> solutionCoordinates;
  final String? targetCorner;

  GameModel get initialModel => GameModel(
        board: GameBoard.fromRows(position.split('/').map((row) {
          return row
              .split('')
              .map((cell) => switch (cell) {
                    'B' => PieceType.black,
                    'W' => PieceType.white,
                    _ => PieceType.empty,
                  })
              .toList();
        }).toList()),
        player: player,
      );

  List<Position> get solutions =>
      solutionCoordinates.map(puzzlePosition).toList(growable: false);

  /// For endgames this verifies that a move preserves a forced win. The
  /// exercise itself only completes after the player reaches a winning finish.
  bool solvesObjective(Position move) {
    final initial = initialModel;
    if (move.x < 0 ||
        move.y < 0 ||
        move.x >= initial.board.size ||
        move.y >= initial.board.size) {
      return false;
    }
    final next = initial.updateForMove(move.x, move.y);
    if (next == null) return false;
    return switch (skill) {
      PuzzleSkill.corner => puzzleCoordinate(move) == targetCorner &&
          next.board.getPieceAtLocation(move.x, move.y) == player,
      PuzzleSkill.forcedPass => next.player == player && !next.gameIsOver,
      PuzzleSkill.endgame => ExactEndgameSolver().score(next, player) > 0,
    };
  }
}

/// Exact minimax for small endgames only. Passes are normalized explicitly;
/// terminal scores are disc differences from [perspective]'s point of view.
/// The strict empty-cell bound prevents accidentally searching a full game.
class ExactEndgameSolver {
  static const maxEmptyCells = 8;
  final Map<String, int> _cache = {};

  int score(GameModel model, PieceType perspective) {
    if (perspective == PieceType.empty ||
        model.board.getPieceCount(PieceType.empty) > maxEmptyCells) {
      throw ArgumentError(
          'Exact solving requires a player and a small endgame');
    }
    return _search(model.board, model.player, perspective);
  }

  int _search(GameBoard board, PieceType player, PieceType perspective) {
    final key = '${player.index}:${perspective.index}:'
        '${board.rows.expand((row) => row).map((piece) => piece.index).join()}';
    final cached = _cache[key];
    if (cached != null) return cached;
    final legal = board.getMovesForPlayer(player);
    if (legal.isEmpty) {
      final other =
          player == PieceType.empty ? PieceType.empty : getOpponent(player);
      if (other != PieceType.empty &&
          board.getMovesForPlayer(other).isNotEmpty) {
        return _cache[key] = _search(board, other, perspective);
      }
      return _cache[key] = board.getPieceCount(perspective) -
          board.getPieceCount(getOpponent(perspective));
    }
    int? best;
    for (final move in legal) {
      final next = GameModel(board: board, player: player)
          .updateForMove(move.x, move.y)!;
      final candidate = _search(next.board, next.player, perspective);
      if (best == null ||
          (player == perspective ? candidate > best : candidate < best)) {
        best = candidate;
      }
    }
    return _cache[key] = best!;
  }

  Position? bestMove(GameModel model, PieceType perspective) {
    // Validate the same strict bound even when there is no legal move.
    score(model, perspective);
    Position? bestMove;
    int? best;
    for (final move in model.board.getMovesForPlayer(model.player)) {
      final value = score(model.updateForMove(move.x, move.y)!, perspective);
      if (best == null ||
          (model.player == perspective ? value > best : value < best)) {
        best = value;
        bestMove = move;
      }
    }
    return bestMove;
  }
}

/// Ordered lessons: recognize a corner, remove an opponent's mobility, then
/// convert increasingly deep endgames. IDs are stable persistence identifiers.
const curatedPuzzles = <ReversiPuzzle>[
  ReversiPuzzle(
    id: 'corner-1',
    number: 1,
    skill: PuzzleSkill.corner,
    position: '..B.../...BW./..BWW./..WBW./.W.B../W..BW.',
    player: PieceType.black,
    openingLine: 'E3 E4 B5 D2 C1 A6 D5 E6 D6 E2',
    solutionCoordinates: ['F6'],
    targetCorner: 'F6',
  ),
  ReversiPuzzle(
    id: 'corner-2',
    number: 2,
    skill: PuzzleSkill.corner,
    position: '.B..W./.WWWWB/..WWW./..BBB./.B.B../....B.',
    player: PieceType.black,
    openingLine: 'D2 C2 B1 E2 F2 D5 B5 E1 E6 B2 E4 E3',
    solutionCoordinates: ['A1'],
    targetCorner: 'A1',
  ),
  ReversiPuzzle(
    id: 'corner-3',
    number: 3,
    skill: PuzzleSkill.corner,
    position: '.B.WW./BBBWBB/..WBW./..BWB./.B.BBB/....B.',
    player: PieceType.white,
    openingLine: 'D2 C2 B1 E2 F2 D5 B5 E1 E6 B2 E4 E3 A2 D1 E5 F5',
    solutionCoordinates: ['A1'],
    targetCorner: 'A1',
  ),
  ReversiPuzzle(
    id: 'pass-1',
    number: 4,
    skill: PuzzleSkill.forcedPass,
    position: 'WWWWW./BWBBBB/.BBBBB/.BBWWW/.BBBWW/....BW',
    player: PieceType.white,
    openingLine:
        'D2 C2 B1 E2 F2 D5 B5 E1 E6 B2 E4 E3 A2 D1 E5 F5 F6 F3 F4 C5 B4 C1 A1 B3',
    solutionCoordinates: ['F1', 'A3'],
  ),
  ReversiPuzzle(
    id: 'pass-2',
    number: 5,
    skill: PuzzleSkill.forcedPass,
    position: '.WWWWW/..WWWW/BBBWWW/BBBWWW/BBBWB./.BBBBB',
    player: PieceType.white,
    openingLine:
        'D2 E2 B4 D1 E1 C2 E3 D5 E6 A4 B3 F1 A5 C5 A3 E5 D6 F2 F3 B5 F6 E4 C1 F4 B6 B1 C6',
    solutionCoordinates: ['F5', 'A6'],
  ),
  ReversiPuzzle(
    id: 'pass-3',
    number: 6,
    skill: PuzzleSkill.forcedPass,
    position: '..BBBB/WWWBBB/WWWBBB/W.BBWB/WWWWWB/BBW.WB',
    player: PieceType.black,
    openingLine:
        'E3 E2 C5 F3 F1 D1 F2 B3 B2 B5 F4 C6 D2 D5 B6 E4 E5 F5 A3 C2 C1 A2 E1 A4 F6 E6 A6 A5',
    solutionCoordinates: ['B4'],
  ),
  ReversiPuzzle(
    id: 'endgame-1',
    number: 7,
    skill: PuzzleSkill.endgame,
    position: 'BWBB../BWWBBB/BWBBBB/WWWWBB/WWBB.W/WBBBBB',
    player: PieceType.white,
    openingLine:
        'E3 E4 B5 D2 C1 A6 D5 E6 D6 E2 F6 C2 B2 C5 D1 C6 F4 F5 B6 A2 B4 A4 F2 A5 A1 B3 A3 B1 F3',
    solutionCoordinates: ['F1', 'E5'],
  ),
  ReversiPuzzle(
    id: 'endgame-2',
    number: 8,
    skill: PuzzleSkill.endgame,
    position: 'BWWWWW/BWWWBW/BBBBWW/BBWB.W/BWBWWW/BW.B..',
    player: PieceType.black,
    openingLine:
        'E3 E2 E1 D5 C5 B5 B4 F1 D2 D1 D6 B6 E5 C2 B2 A5 A4 F3 A6 A2 A1 B3 F2 B1 F4 F5 A3 C1',
    solutionCoordinates: ['C6'],
  ),
  ReversiPuzzle(
    id: 'endgame-3',
    number: 9,
    skill: PuzzleSkill.endgame,
    position: '..WWW./WWWB../BBBB.B/BBBBWB/BBWWBB/BWWWBB',
    player: PieceType.black,
    openingLine:
        'C5 B5 B4 D5 E4 F5 E6 A4 D2 E1 F3 F4 A6 E5 F6 B6 A5 D6 B2 C2 D1 C1 A3 A2 B3 C6',
    solutionCoordinates: ['A1', 'E3'],
  ),
];
