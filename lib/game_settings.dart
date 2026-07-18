// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'game_board.dart';
import 'generated/l10n.dart';

/// How strong the CPU opponent plays. Only relevant outside of 2-player mode.
///
/// [superEasy] is intentionally last so the stored indexes for the original
/// three difficulties remain backward compatible.
enum Difficulty { easy, medium, hard, superEasy }

extension DifficultyLabel on Difficulty {
  String label(BuildContext context) {
    switch (this) {
      case Difficulty.superEasy:
        return S.of(context).DifficultySuperEasy;
      case Difficulty.easy:
        return S.of(context).DifficultyEasy;
      case Difficulty.medium:
        return S.of(context).DifficultyMedium;
      case Difficulty.hard:
        return S.of(context).DifficultyHard;
    }
  }

  int get boardSize => this == Difficulty.superEasy
      ? GameBoard.compactSize
      : GameBoard.standardSize;
}

/// Which side the human plays when there's a single human player.
enum FirstPlayer { human, computer, random }

extension FirstPlayerLabel on FirstPlayer {
  String label(BuildContext context) {
    switch (this) {
      case FirstPlayer.human:
        return S.of(context).FirstPlayerHuman;
      case FirstPlayer.computer:
        return S.of(context).FirstPlayerComputer;
      case FirstPlayer.random:
        return S.of(context).FirstPlayerRandom;
    }
  }
}

/// Everything chosen on the start screen that a game needs in order to run:
/// how hard the CPU plays, whether there even is a CPU (2-player mode), and
/// which color the human is playing (black always moves first in Reversi, so
/// this is what "who goes first" resolves to).
class GameSettings {
  final Difficulty difficulty;
  final bool twoPlayerMode;
  final PieceType humanColor;
  final bool isDailyChallenge;
  final GameBoard? initialBoard;
  final PieceType? initialPlayer;

  const GameSettings({
    required this.difficulty,
    required this.twoPlayerMode,
    this.humanColor = PieceType.black,
    this.isDailyChallenge = false,
    this.initialBoard,
    this.initialPlayer,
  });

  int get boardSize => initialBoard?.size ?? difficulty.boardSize;
}
