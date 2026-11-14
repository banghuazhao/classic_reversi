// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'game_board.dart';
import 'generated/l10n.dart';

/// How strong the CPU opponent plays. Only relevant outside of 2-player mode.
///
/// New levels are appended so stored indexes remain backward compatible.
/// [expert] is the Premium opponent.
enum Difficulty { easy, medium, hard, superEasy, expert }

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
      case Difficulty.expert:
        return S.of(context).DifficultyExpert;
    }
  }

  /// Difficulties offered in game setup, from gentlest to strongest.
  static const ordered = [
    Difficulty.superEasy,
    Difficulty.easy,
    Difficulty.medium,
    Difficulty.hard,
    Difficulty.expert,
  ];

  bool get requiresPremium => this == Difficulty.expert;

  /// Levels where undo and legal-move hints cost a rewarded ad without
  /// Premium.
  bool get isAdvanced => this == Difficulty.hard || this == Difficulty.expert;

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

  /// The calendar date that generated this puzzle, retained across rematches.
  final DateTime? dailyChallengeDate;
  final GameBoard? initialBoard;
  final PieceType? initialPlayer;

  const GameSettings({
    required this.difficulty,
    required this.twoPlayerMode,
    this.humanColor = PieceType.black,
    this.isDailyChallenge = false,
    this.dailyChallengeDate,
    this.initialBoard,
    this.initialPlayer,
  });

  int get boardSize => initialBoard?.size ?? difficulty.boardSize;
}
