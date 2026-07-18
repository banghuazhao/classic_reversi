import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'settings_service.dart';

enum GameSound { place, flip, win, lose }

/// Plays short SFX and haptics, gated by user preferences.
class FeedbackService {
  FeedbackService._();
  static final FeedbackService instance = FeedbackService._();

  // Separate players so place + flip can overlap without cutting each other.
  final AudioPlayer _primary = AudioPlayer();
  final AudioPlayer _secondary = AudioPlayer();
  bool _ready = false;
  bool _soundEnabled = true;
  bool _hapticsEnabled = true;

  Future<void> init() async {
    if (kIsWeb) {
      return;
    }
    try {
      _soundEnabled = await SettingsService.getSoundEnabled();
      _hapticsEnabled = await SettingsService.getHapticsEnabled();
      await _primary.setReleaseMode(ReleaseMode.stop);
      await _secondary.setReleaseMode(ReleaseMode.stop);
      _ready = true;
    } catch (error) {
      print('FeedbackService init failed: $error');
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

  Future<void> play(GameSound sound, {bool secondary = false}) async {
    if (!_soundEnabled || kIsWeb) {
      return;
    }
    try {
      if (!_ready) {
        await init();
      }
      final player = secondary ? _secondary : _primary;
      await player.stop();
      await player.play(AssetSource('sounds/${sound.name}.wav'));
    } catch (error) {
      print('FeedbackService play failed: $error');
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
    await hapticLight();
    await play(GameSound.place);
    if (flippedCount > 0) {
      Future<void>.delayed(const Duration(milliseconds: 80), () {
        play(GameSound.flip, secondary: true);
      });
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
    await _primary.dispose();
    await _secondary.dispose();
    _ready = false;
  }
}
