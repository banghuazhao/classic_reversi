// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'game_board.dart';

/// The Theme class is part of Flutter's Material Design package, which this
/// game doesn't use. Instead, this static class is used as a convenient spot to
/// hold constants for colors, text styles, and so on.
///
/// While a larger app would need something more sophisticated, for a simple,
/// one-screen game, this gets the job done just fine.
abstract class Styling {
  // **** GRADIENTS AND COLORS ****

  static const Map<PieceType, LinearGradient> pieceGradients = {
    PieceType.black: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xff101010),
        Color(0xff303030),
      ],
    ),
    PieceType.white: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xffffffff),
        Color(0xffe0e0e0),
      ],
    ),
    PieceType.empty: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0x60ffffff),
        Color(0x40ffffff),
      ],
    ),
  };

  static const backgroundStartColor = Color(0xb0E6A763);
  static const backgroundFinishColor = Color(0xb0AE561B);
  static const thinkingColor = Color(0xa0ffffff);

  // **** ANIMATIONS ****

  static const Duration thinkingFadeDuration = Duration(milliseconds: 500);

  static const pieceFlipDuration = Duration(milliseconds: 300);

  // **** SIZES ****

  static const thinkingSize = 10.0;

  // **** TEXT ****

  static const scoreText = TextStyle(
      fontSize: 45.0,
      fontFamily: 'Roboto',
      color: Color(0xffffffff),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w900);

  static const scoreLabelText = TextStyle(
      fontSize: 25.0,
      fontFamily: 'Roboto',
      color: Color(0xffffffff),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w900);

  static const scoreTextBlack = TextStyle(
      fontSize: 45.0,
      fontFamily: 'Roboto',
      color: Color(0xff000000),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w900);

  static const scoreLabelTextBlack = TextStyle(
      fontSize: 25.0,
      fontFamily: 'Roboto',
      color: Color(0xff000000),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w900);

  static const resultText = TextStyle(
      fontSize: 45.0,
      fontFamily: 'Roboto',
      color: Color(0xe0ffffff),
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w900);

  static const buttonText = TextStyle(
      fontSize: 25.0,
      fontFamily: 'Roboto',
      color: Color(0xe0ffffff),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w900);

  // **** BOXES ****

  static const activePlayerIndicator = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 2.0,
        color: Color(0xffffffff),
      ),
    ),
  );

  static const activePlayerIndicatorBlack = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 2.0,
        color: Color(0xff000000),
      ),
    ),
  );

  static const inactivePlayerIndicator = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 2.0,
        color: Color(0x00000000),
      ),
    ),
  );
}
