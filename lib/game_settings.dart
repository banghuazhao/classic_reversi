// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'game_board.dart';

/// How strong the CPU opponent plays. Only relevant outside of 2-player mode.
enum Difficulty { easy, medium, hard }

extension DifficultyLabel on Difficulty {
  String get label {
    switch (this) {
      case Difficulty.easy:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.hard:
        return 'Hard';
    }
  }
}

/// Which side the human plays when there's a single human player.
enum FirstPlayer { human, computer, random }

extension FirstPlayerLabel on FirstPlayer {
  String get label {
    switch (this) {
      case FirstPlayer.human:
        return 'Player';
      case FirstPlayer.computer:
        return 'Computer';
      case FirstPlayer.random:
        return 'Random';
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

  const GameSettings({
    required this.difficulty,
    required this.twoPlayerMode,
    this.humanColor = PieceType.black,
  });
}
