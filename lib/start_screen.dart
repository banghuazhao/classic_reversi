// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game_board.dart';
import 'game_settings.dart';
import 'main.dart';
import 'settings_service.dart';
import 'styling.dart';

/// The very first screen the player sees: pick a difficulty, choose who goes
/// first (or play locally with a friend), see the running win/loss record,
/// then start a game. Shown again whenever the player wants a new game with
/// different settings (the restart button in [GameScreen] returns here).
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Difficulty _difficulty = Difficulty.hard;
  FirstPlayer _firstPlayer = FirstPlayer.human;
  bool _twoPlayerMode = false;
  int _wins = 0;
  int _losses = 0;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final difficulty = await SettingsService.getDifficulty();
    final firstPlayer = await SettingsService.getFirstPlayer();
    final wins = await SettingsService.getWins();
    final losses = await SettingsService.getLosses();
    if (!mounted) return;
    setState(() {
      _difficulty = difficulty;
      _firstPlayer = firstPlayer;
      _wins = wins;
      _losses = losses;
    });
  }

  void _startGame() {
    SettingsService.setDifficulty(_difficulty);
    SettingsService.setFirstPlayer(_firstPlayer);

    PieceType humanColor = PieceType.black;
    if (!_twoPlayerMode) {
      switch (_firstPlayer) {
        case FirstPlayer.human:
          humanColor = PieceType.black;
          break;
        case FirstPlayer.computer:
          humanColor = PieceType.white;
          break;
        case FirstPlayer.random:
          humanColor = Random().nextBool() ? PieceType.black : PieceType.white;
          break;
      }
    }

    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (context) => GameScreen(
          settings: GameSettings(
            difficulty: _difficulty,
            twoPlayerMode: _twoPlayerMode,
            humanColor: humanColor,
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: Styling.scoreLabelText.copyWith(fontSize: 18),
      ),
    );
  }

  // A minimal on/off switch that doesn't need a Material ancestor, since this
  // app deliberately doesn't use MaterialApp/Theme (see main.dart).
  Widget _toggleSwitch(bool value) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 46,
      height: 28,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: value ? Color(0xffffffff) : Color(0x60ffffff),
        borderRadius: BorderRadius.circular(14),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 150),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: value ? Styling.backgroundFinishColor : Color(0xffffffff),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _segmentedControl<T>({
    required List<T> values,
    required T selected,
    required String Function(T) labelFor,
    required ValueChanged<T> onSelected,
  }) {
    return Row(
      children: values.map((value) {
        final isSelected = value == selected;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => onSelected(value),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xffffffff) : Color(0x40ffffff),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  labelFor(value),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: isSelected ? Color(0xff000000) : Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Styling.backgroundStartColor,
            Styling.backgroundFinishColor,
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                'Classic Reversi',
                textAlign: TextAlign.center,
                style: Styling.resultText.copyWith(fontSize: 36),
              ),
              SizedBox(height: 10),
              Text(
                'Wins $_wins · Losses $_losses',
                textAlign: TextAlign.center,
                style: Styling.scoreLabelText.copyWith(fontSize: 16),
              ),
              SizedBox(height: 40),
              _sectionLabel('Difficulty'),
              _segmentedControl<Difficulty>(
                values: Difficulty.values,
                selected: _difficulty,
                labelFor: (d) => d.label,
                onSelected: (d) => setState(() => _difficulty = d),
              ),
              SizedBox(height: 30),
              _sectionLabel('2 Players (pass & play)'),
              GestureDetector(
                onTap: () => setState(() => _twoPlayerMode = !_twoPlayerMode),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color(0x40ffffff),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Play against a friend on this device',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      _toggleSwitch(_twoPlayerMode),
                    ],
                  ),
                ),
              ),
              if (!_twoPlayerMode) ...[
                SizedBox(height: 30),
                _sectionLabel('Who goes first?'),
                _segmentedControl<FirstPlayer>(
                  values: FirstPlayer.values,
                  selected: _firstPlayer,
                  labelFor: (f) => f.label,
                  onSelected: (f) => setState(() => _firstPlayer = f),
                ),
              ],
              SizedBox(height: 40),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffffffff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Start Game',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
