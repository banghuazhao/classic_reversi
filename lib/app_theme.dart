// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'game_board.dart';
import 'generated/l10n.dart';

enum BoardThemeId { classic, night, contrast }

extension BoardThemeIdLabel on BoardThemeId {
  String label(BuildContext context) {
    switch (this) {
      case BoardThemeId.classic:
        return S.of(context).ThemeClassic;
      case BoardThemeId.night:
        return S.of(context).ThemeNight;
      case BoardThemeId.contrast:
        return S.of(context).ThemeContrast;
    }
  }
}

/// Visual palette for the board and chrome. Selected via settings.
class AppTheme {
  final Color backgroundStart;
  final Color backgroundFinish;
  final Color thinking;
  final Color lastMoveBorder;
  final Color hintDot;
  final Color buttonFill;
  final Color scoreWhite;
  final Color scoreBlack;
  final Map<PieceType, LinearGradient> pieceGradients;

  const AppTheme({
    required this.backgroundStart,
    required this.backgroundFinish,
    required this.thinking,
    required this.lastMoveBorder,
    required this.hintDot,
    required this.buttonFill,
    required this.scoreWhite,
    required this.scoreBlack,
    required this.pieceGradients,
  });

  static const classic = AppTheme(
    backgroundStart: Color(0xb0E6A763),
    backgroundFinish: Color(0xb0AE561B),
    thinking: Color(0xa0ffffff),
    lastMoveBorder: Color(0xffFFC107),
    hintDot: Color(0x60ffffff),
    buttonFill: Color(0x60421E08),
    scoreWhite: Color(0xffffffff),
    scoreBlack: Color(0xff000000),
    pieceGradients: {
      PieceType.black: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff101010), Color(0xff303030)],
      ),
      PieceType.white: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffffffff), Color(0xffe0e0e0)],
      ),
      PieceType.empty: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0x60ffffff), Color(0x40ffffff)],
      ),
    },
  );

  static const night = AppTheme(
    backgroundStart: Color(0xff1B2838),
    backgroundFinish: Color(0xff0D1520),
    thinking: Color(0xa0ffffff),
    lastMoveBorder: Color(0xff64B5F6),
    hintDot: Color(0x50ffffff),
    buttonFill: Color(0x60304050),
    scoreWhite: Color(0xffffffff),
    scoreBlack: Color(0xffB0BEC5),
    pieceGradients: {
      PieceType.black: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff0A0A0A), Color(0xff2A2A2A)],
      ),
      PieceType.white: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffF5F5F5), Color(0xffCFD8DC)],
      ),
      PieceType.empty: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0x402A3A4A), Color(0x30182028)],
      ),
    },
  );

  static const contrast = AppTheme(
    backgroundStart: Color(0xff2E7D32),
    backgroundFinish: Color(0xff1B5E20),
    thinking: Color(0xffffffff),
    lastMoveBorder: Color(0xffffEB3B),
    hintDot: Color(0x90ffffff),
    buttonFill: Color(0x80000000),
    scoreWhite: Color(0xffffffff),
    scoreBlack: Color(0xff000000),
    pieceGradients: {
      PieceType.black: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff000000), Color(0xff222222)],
      ),
      PieceType.white: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffffffff), Color(0xffeeeeee)],
      ),
      PieceType.empty: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0x70ffffff), Color(0x50ffffff)],
      ),
    },
  );

  static AppTheme forId(BoardThemeId id) {
    switch (id) {
      case BoardThemeId.classic:
        return classic;
      case BoardThemeId.night:
        return night;
      case BoardThemeId.contrast:
        return contrast;
    }
  }
}
