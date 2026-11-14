// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'game_board.dart';
import 'generated/l10n.dart';

/// Appended values keep stored indexes stable. [royal] and [ember] are
/// Premium themes.
enum BoardThemeId { classic, night, contrast, royal, ember }

extension BoardThemeIdLabel on BoardThemeId {
  String label(BuildContext context) {
    switch (this) {
      case BoardThemeId.classic:
        return S.of(context).ThemeClassic;
      case BoardThemeId.night:
        return S.of(context).ThemeNight;
      case BoardThemeId.contrast:
        return S.of(context).ThemeContrast;
      case BoardThemeId.royal:
        return S.of(context).ThemeRoyal;
      case BoardThemeId.ember:
        return S.of(context).ThemeEmber;
    }
  }

  bool get requiresPremium =>
      this == BoardThemeId.royal || this == BoardThemeId.ember;
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
    backgroundStart: Color(0xff3B2A24),
    backgroundFinish: Color(0xff241B18),
    thinking: Color(0xa0ffffff),
    lastMoveBorder: Color(0xffE4C18B),
    hintDot: Color(0x60ffffff),
    buttonFill: Color(0xff4D382D),
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
    backgroundStart: Color(0xff19232A),
    backgroundFinish: Color(0xff11191F),
    thinking: Color(0xa0ffffff),
    lastMoveBorder: Color(0xff9CCAD0),
    hintDot: Color(0x50ffffff),
    buttonFill: Color(0xff26363D),
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
    backgroundStart: Color(0xff12261A),
    backgroundFinish: Color(0xff09180F),
    thinking: Color(0xffffffff),
    lastMoveBorder: Color(0xffffEB3B),
    hintDot: Color(0x90ffffff),
    buttonFill: Color(0xff223C26),
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

  /// Premium: deep violet felt framed in gold.
  static const royal = AppTheme(
    backgroundStart: Color(0xff2E1F3D),
    backgroundFinish: Color(0xff1A1124),
    thinking: Color(0xa0ffffff),
    lastMoveBorder: Color(0xffF2C46D),
    hintDot: Color(0x60ffffff),
    buttonFill: Color(0xff3D2A52),
    scoreWhite: Color(0xffffffff),
    scoreBlack: Color(0xff000000),
    tableGrainLight: Color(0xffb79be0),
    tableGrainDark: Color(0xff12081c),
    boardFrameLight: Color(0xffd4a64a),
    boardFrameMid: Color(0xff8e6a24),
    boardFrameDark: Color(0xff3b2a0c),
    boardFrameHighlight: Color(0xfffff0b3),
    boardSurfaceLight: Color(0xff4b3a78),
    boardSurfaceDark: Color(0xff221848),
    boardCellLight: Color(0xffa99be0),
    boardCellDark: Color(0xff100a2a),
    boardGrooveLight: Color(0xff7d6cc0),
    boardGrooveDark: Color(0xff0a0620),
    pieceGradients: {
      PieceType.black: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff36323f), Color(0xff050408), Color(0xff1a1720)],
        stops: [0, 0.62, 1],
      ),
      PieceType.white: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffffffff), Color(0xffe2dbcc), Color(0xfff8f2e6)],
        stops: [0, 0.68, 1],
      ),
      PieceType.empty: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0x50ffffff), Color(0x30ffffff)],
      ),
    },
  );

  /// Premium: warm crimson felt with a copper frame.
  static const ember = AppTheme(
    backgroundStart: Color(0xff3A1A17),
    backgroundFinish: Color(0xff1F0E0C),
    thinking: Color(0xa0ffffff),
    lastMoveBorder: Color(0xffFFA86B),
    hintDot: Color(0x60ffffff),
    buttonFill: Color(0xff4E2420),
    scoreWhite: Color(0xffffffff),
    scoreBlack: Color(0xff000000),
    tableGrainLight: Color(0xffffb38a),
    tableGrainDark: Color(0xff2a0805),
    boardFrameLight: Color(0xffb4683f),
    boardFrameMid: Color(0xff7a3b20),
    boardFrameDark: Color(0xff2f1208),
    boardFrameHighlight: Color(0xffffc49a),
    boardSurfaceLight: Color(0xff8a3a33),
    boardSurfaceDark: Color(0xff441613),
    boardCellLight: Color(0xffeaa89c),
    boardCellDark: Color(0xff240807),
    boardGrooveLight: Color(0xffbd6e64),
    boardGrooveDark: Color(0xff180505),
    pieceGradients: {
      PieceType.black: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xff3a3434), Color(0xff060404), Color(0xff1c1616)],
        stops: [0, 0.62, 1],
      ),
      PieceType.white: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffffffff), Color(0xffe6d9cf), Color(0xfffaf1ea)],
        stops: [0, 0.68, 1],
      ),
      PieceType.empty: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0x50ffffff), Color(0x30ffffff)],
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
      case BoardThemeId.royal:
        return royal;
      case BoardThemeId.ember:
        return ember;
    }
  }
}
