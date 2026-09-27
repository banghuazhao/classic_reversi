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
  final Color tableGrainLight;
  final Color tableGrainDark;
  final Color boardFrameLight;
  final Color boardFrameMid;
  final Color boardFrameDark;
  final Color boardFrameHighlight;
  final Color boardSurfaceLight;
  final Color boardSurfaceDark;
  final Color boardCellLight;
  final Color boardCellDark;
  final Color boardGrooveLight;
  final Color boardGrooveDark;
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
    required this.tableGrainLight,
    required this.tableGrainDark,
    required this.boardFrameLight,
    required this.boardFrameMid,
    required this.boardFrameDark,
    required this.boardFrameHighlight,
    required this.boardSurfaceLight,
    required this.boardSurfaceDark,
    required this.boardCellLight,
    required this.boardCellDark,
    required this.boardGrooveLight,
    required this.boardGrooveDark,
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
    tableGrainLight: Color(0xffffd9a1),
    tableGrainDark: Color(0xff4a1e09),
    boardFrameLight: Color(0xffa76736),
    boardFrameMid: Color(0xff70401f),
    boardFrameDark: Color(0xff32170a),
    boardFrameHighlight: Color(0xffffcc85),
    boardSurfaceLight: Color(0xff397658),
    boardSurfaceDark: Color(0xff174330),
    boardCellLight: Color(0xffa3e2bd),
    boardCellDark: Color(0xff082a1e),
    boardGrooveLight: Color(0xff75b993),
    boardGrooveDark: Color(0xff071d15),
    pieceGradients: {
      PieceType.black: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff353638), Color(0xff050607), Color(0xff191a1c)],
        stops: [0, 0.62, 1],
      ),
      PieceType.white: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffffffff), Color(0xffd9d5ca), Color(0xfff4efe4)],
        stops: [0, 0.68, 1],
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
    tableGrainLight: Color(0xff718aa2),
    tableGrainDark: Color(0xff03070c),
    boardFrameLight: Color(0xff3d5062),
    boardFrameMid: Color(0xff243342),
    boardFrameDark: Color(0xff0a1119),
    boardFrameHighlight: Color(0xff9ab3ca),
    boardSurfaceLight: Color(0xff28575a),
    boardSurfaceDark: Color(0xff0e2930),
    boardCellLight: Color(0xff79b7b4),
    boardCellDark: Color(0xff041a20),
    boardGrooveLight: Color(0xff518b8d),
    boardGrooveDark: Color(0xff020e13),
    pieceGradients: {
      PieceType.black: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff34383c), Color(0xff040506), Color(0xff15191c)],
        stops: [0, 0.62, 1],
      ),
      PieceType.white: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffffffff), Color(0xffc9d2d5), Color(0xffedf2f2)],
        stops: [0, 0.68, 1],
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
    tableGrainLight: Color(0xff8ddf94),
    tableGrainDark: Color(0xff031807),
    boardFrameLight: Color(0xff405943),
    boardFrameMid: Color(0xff223c26),
    boardFrameDark: Color(0xff061409),
    boardFrameHighlight: Color(0xffbce9b7),
    boardSurfaceLight: Color(0xff36a150),
    boardSurfaceDark: Color(0xff0c5724),
    boardCellLight: Color(0xffb5f3bd),
    boardCellDark: Color(0xff02290d),
    boardGrooveLight: Color(0xff8adb96),
    boardGrooveDark: Color(0xff001c08),
    pieceGradients: {
      PieceType.black: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff3a3a3a), Color(0xff000000), Color(0xff171717)],
        stops: [0, 0.6, 1],
      ),
      PieceType.white: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffffffff), Color(0xffd7d7d7), Color(0xffffffff)],
        stops: [0, 0.68, 1],
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
