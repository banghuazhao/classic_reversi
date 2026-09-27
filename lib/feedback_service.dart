import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'settings_service.dart';

enum GameSound { place, flip, win, lose }

/// Plays short SFX and haptics, gated by user preferences.
class FeedbackService extends ChangeNotifier {
  FeedbackService._();
  static final FeedbackService instance = FeedbackService._();

  // Pools keep the tiny placement/flip samples warm and allow a capture wave
  // to overlap instead of cutting the previous tick short.
  List<AudioPool> _placePools = [];
  List<AudioPool> _flipPools = [];
  final AudioPlayer _resultPlayer = AudioPlayer();
  Future<void>? _initializing;
  Future<void>? _audioInitializing;
  int _soundSequence = 0;
  bool _ready = false;
  bool _soundEnabled = true;
  bool _hapticsEnabled = true;
  bool _reduceMotion = false;
  FeedbackIntensity _intensity = FeedbackIntensity.balanced;

  bool get reduceMotion => _reduceMotion;
  FeedbackIntensity get intensity => _intensity;

  double get effectScale => switch (_intensity) {
        FeedbackIntensity.gentle => 0.65,
        FeedbackIntensity.balanced => 1.0,
        FeedbackIntensity.lively => 1.3,
      };

  double get audioScale => switch (_intensity) {
        FeedbackIntensity.gentle => 0.76,
        FeedbackIntensity.balanced => 1.0,
        FeedbackIntensity.lively => 1.12,
      };

  Future<void> init() async {
    if (_ready) {
      return;
    }
    final initializing = _initializing;
    if (initializing != null) {
      return initializing;
    }
    final future = _initialize();
    _initializing = future;
    return future;
  }

  Future<void> _initialize() async {
    try {
      _soundEnabled = await SettingsService.getSoundEnabled();
      _hapticsEnabled = await SettingsService.getHapticsEnabled();
      _reduceMotion = await SettingsService.getReduceMotion();
      _intensity = await SettingsService.getFeedbackIntensity();
    } catch (error) {
      debugPrint('FeedbackService preference load failed: $error');
    }

    if (_soundEnabled) {
      await _ensureAudioReady();
    }
    _ready = true;
    _initializing = null;
    notifyListeners();
  }

  Future<void> setSoundEnabled(bool enabled) async {
    _soundEnabled = enabled;
    notifyListeners();
    await SettingsService.setSoundEnabled(enabled);
    if (enabled) {
      await _ensureAudioReady();
    }
  }

  Future<void> setHapticsEnabled(bool enabled) async {
    _hapticsEnabled = enabled;
    notifyListeners();
    await SettingsService.setHapticsEnabled(enabled);
  }

  Future<void> setReduceMotion(bool enabled) async {
    _reduceMotion = enabled;
    notifyListeners();
    await SettingsService.setReduceMotion(enabled);
  }

  Future<void> setIntensity(FeedbackIntensity value) async {
    _intensity = value;
    notifyListeners();
    await SettingsService.setFeedbackIntensity(value);
  }

  Future<void> play(
    GameSound sound, {
    double volume = 1,
    int variant = 0,
  }) async {
    if (!_soundEnabled || kIsWeb) {
      return;
    }
    try {
      if (!_ready) {
        await init();
      }
      if (!_soundEnabled) {
        return;
      }
      await _ensureAudioReady();
      switch (sound) {
        case GameSound.place:
          if (_placePools.isNotEmpty) {
            await _placePools[variant % _placePools.length].start(
              volume: volume,
            );
          }
          break;
        case GameSound.flip:
          if (_flipPools.isNotEmpty) {
            await _flipPools[variant % _flipPools.length].start(
              volume: volume,
            );
          }
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

  Future<void> _ensureAudioReady() async {
    if (kIsWeb || _placePools.isNotEmpty) {
      return;
    }
    final initializing = _audioInitializing;
    if (initializing != null) {
      return initializing;
    }
    final future = _loadAudioPools();
    _audioInitializing = future;
    return future;
  }

  Future<void> _loadAudioPools() async {
    try {
      await _resultPlayer.setReleaseMode(ReleaseMode.stop);
      _placePools = await Future.wait(
        const [
          'sounds/place.wav',
          'sounds/place_soft.wav',
          'sounds/place_crisp.wav',
        ].map(
          (path) => AudioPool.createFromAsset(
            path: path,
            minPlayers: 1,
            maxPlayers: 2,
          ),
        ),
      );
      _flipPools = await Future.wait(
        const [
          'sounds/flip.wav',
          'sounds/flip_soft.wav',
          'sounds/flip_crisp.wav',
        ].map(
          (path) => AudioPool.createFromAsset(
            path: path,
            minPlayers: 1,
            maxPlayers: 3,
          ),
        ),
      );
    } catch (error) {
      debugPrint('FeedbackService audio init failed: $error');
    } finally {
      _audioInitializing = null;
    }
  }

  Future<void> hapticMedium() async {
    if (!_hapticsEnabled) {
      return;
    }
    await HapticFeedback.mediumImpact();
  }

  Future<void> invalidMoveFeedback() async {
    if (!_hapticsEnabled) {
      return;
    }
    await HapticFeedback.selectionClick();
  }

  Future<void> moveFeedback({required int flippedCount}) async {
    final sequence = _soundSequence++;
    final volumeScale = audioScale;
    await Future.wait([
      _moveHaptic(flippedCount),
      play(
        GameSound.place,
        volume: (0.82 * volumeScale).clamp(0.0, 1.0),
        variant: sequence,
      ),
    ]);

    final baseFlipTicks = switch (flippedCount) {
      >= 7 => 3,
      >= 3 => 2,
      >= 1 => 1,
      _ => 0,
    };
    final flipTicks = switch (_intensity) {
      FeedbackIntensity.gentle => baseFlipTicks.clamp(0, 1),
      FeedbackIntensity.balanced => baseFlipTicks,
      FeedbackIntensity.lively when flippedCount >= 3 =>
        (baseFlipTicks + 1).clamp(0, 3),
      FeedbackIntensity.lively => baseFlipTicks,
    };
    for (var i = 0; i < flipTicks; i++) {
      unawaited(
        Future<void>.delayed(
          Duration(milliseconds: 72 + i * 55),
          () => play(
            GameSound.flip,
            volume: ((0.48 - i * 0.06) * volumeScale).clamp(0.0, 1.0),
            variant: sequence + i + 1,
          ),
        ),
      );
    }
  }

  Future<void> _moveHaptic(int flippedCount) async {
    switch (_intensity) {
      case FeedbackIntensity.gentle:
        if (_hapticsEnabled) {
          await HapticFeedback.selectionClick();
        }
        break;
      case FeedbackIntensity.balanced:
        await (flippedCount >= 7 ? hapticMedium() : hapticLight());
        break;
      case FeedbackIntensity.lively:
        await (flippedCount >= 4 ? hapticMedium() : hapticLight());
        break;
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
    await play(
      humanWon ? GameSound.win : GameSound.lose,
      volume: audioScale.clamp(0.0, 1.0),
    );
  }

  @override
  void dispose() {
    for (final pool in _placePools) {
      unawaited(pool.dispose());
    }
    for (final pool in _flipPools) {
      unawaited(pool.dispose());
    }
    unawaited(_resultPlayer.dispose());
    _placePools = [];
    _flipPools = [];
    _ready = false;
    super.dispose();
  }
}
