import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'settings_service.dart';

enum GameSound { place, flip, win, lose }

/// Plays short SFX and haptics, gated by user preferences.
class FeedbackService {
  FeedbackService._();
  static final FeedbackService instance = FeedbackService._();

  // Pools keep the tiny placement/flip samples warm and allow a capture wave
  // to overlap instead of cutting the previous tick short.
  AudioPool? _placePool;
  AudioPool? _flipPool;
  final AudioPlayer _resultPlayer = AudioPlayer();
  Future<void>? _initializing;
  bool _ready = false;
  bool _soundEnabled = true;
  bool _hapticsEnabled = true;

  Future<void> init() async {
    if (kIsWeb || _ready) {
      return;
    }
    final initializing = _initializing;
    if (initializing != null) {
      return initializing;
    }
    _initializing = _initialize();
    return _initializing;
  }

  Future<void> _initialize() async {
    try {
      _soundEnabled = await SettingsService.getSoundEnabled();
      _hapticsEnabled = await SettingsService.getHapticsEnabled();
      await _resultPlayer.setReleaseMode(ReleaseMode.stop);
      _placePool = await AudioPool.createFromAsset(
        path: 'sounds/place.wav',
        minPlayers: 1,
        maxPlayers: 2,
      );
      _flipPool = await AudioPool.createFromAsset(
        path: 'sounds/flip.wav',
        minPlayers: 2,
        maxPlayers: 4,
      );
      _ready = true;
    } catch (error) {
      debugPrint('FeedbackService init failed: $error');
    } finally {
      _initializing = null;
    }
  }

  Future<void> setSoundEnabled(bool enabled) async {
    _soundEnabled = enabled;
    await SettingsService.setSoundEnabled(enabled);
  }

  Future<void> setHapticsEnabled(bool enabled) async {
    _hapticsEnabled = enabled;
    await SettingsService.setHapticsEnabled(enabled);
  }

  Future<void> play(GameSound sound, {double volume = 1}) async {
    if (!_soundEnabled || kIsWeb) {
      return;
    }
    try {
      if (!_ready) {
        await init();
      }
      switch (sound) {
        case GameSound.place:
          await _placePool?.start(volume: volume);
          break;
        case GameSound.flip:
          await _flipPool?.start(volume: volume);
          break;
        case GameSound.win:
        case GameSound.lose:
          await _resultPlayer.stop();
          await _resultPlayer.play(
            AssetSource('sounds/${sound.name}.wav'),
            volume: volume,
          );
          break;
      }
    } catch (error) {
      debugPrint('FeedbackService play failed: $error');
    }
  }

  Future<void> hapticLight() async {
    if (!_hapticsEnabled) {
      return;
    }
    await HapticFeedback.lightImpact();
  }

  Future<void> hapticMedium() async {
    if (!_hapticsEnabled) {
      return;
    }
    await HapticFeedback.mediumImpact();
  }

  Future<void> moveFeedback({required int flippedCount}) async {
    await Future.wait([
      flippedCount >= 7 ? hapticMedium() : hapticLight(),
      play(GameSound.place, volume: 0.82),
    ]);

    final flipTicks = switch (flippedCount) {
      >= 7 => 3,
      >= 3 => 2,
      >= 1 => 1,
      _ => 0,
    };
    for (var i = 0; i < flipTicks; i++) {
      unawaited(
        Future<void>.delayed(
          Duration(milliseconds: 72 + i * 55),
          () => play(GameSound.flip, volume: 0.48 - i * 0.06),
        ),
      );
    }
  }

  Future<void> gameOverFeedback({
    required bool humanWon,
    required bool tie,
  }) async {
    if (tie) {
      await hapticLight();
      return;
    }
    await hapticMedium();
    await play(humanWon ? GameSound.win : GameSound.lose);
  }

  Future<void> dispose() async {
    await _placePool?.dispose();
    await _flipPool?.dispose();
    await _resultPlayer.dispose();
    _placePool = null;
    _flipPool = null;
    _ready = false;
  }
}
