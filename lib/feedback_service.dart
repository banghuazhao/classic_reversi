import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'settings_service.dart';

enum GameSound { place, flip, win, lose }

/// Plays short SFX and haptics, gated by user preferences.
class FeedbackService {
  FeedbackService._();
  static final FeedbackService instance = FeedbackService._();

  final AudioPlayer _player = AudioPlayer();
  bool _ready = false;

  Future<void> init() async {
    if (_ready || kIsWeb) {
      return;
    }
    try {
      await _player.setReleaseMode(ReleaseMode.stop);
      _ready = true;
    } catch (error) {
      print('FeedbackService init failed: $error');
    }
  }

  Future<void> play(GameSound sound) async {
    if (!await SettingsService.getSoundEnabled()) {
      return;
    }
    if (kIsWeb) {
      return;
    }
    try {
      if (!_ready) {
        await init();
      }
      await _player.stop();
      await _player.play(AssetSource('sounds/${sound.name}.wav'));
    } catch (error) {
      print('FeedbackService play failed: $error');
    }
  }

  Future<void> hapticLight() async {
    if (!await SettingsService.getHapticsEnabled()) {
      return;
    }
    await HapticFeedback.lightImpact();
  }

  Future<void> hapticMedium() async {
    if (!await SettingsService.getHapticsEnabled()) {
      return;
    }
    await HapticFeedback.mediumImpact();
  }

  Future<void> moveFeedback({required int flippedCount}) async {
    await hapticLight();
    await play(GameSound.place);
    if (flippedCount > 0) {
      // Slight delay so place and flip don't completely overlap.
      Future<void>.delayed(const Duration(milliseconds: 80), () {
        play(GameSound.flip);
      });
    }
  }

  Future<void> gameOverFeedback({required bool humanWon, required bool tie}) async {
    if (tie) {
      await hapticLight();
      return;
    }
    await hapticMedium();
    await play(humanWon ? GameSound.win : GameSound.lose);
  }

  Future<void> dispose() async {
    await _player.dispose();
    _ready = false;
  }
}
