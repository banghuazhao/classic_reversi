import 'package:flutter/foundation.dart';

import 'app_theme.dart';
import 'settings_service.dart';

/// Notifies the UI when the player changes board theme.
class ThemeController extends ChangeNotifier {
  ThemeController._();
  static final ThemeController instance = ThemeController._();

  BoardThemeId _themeId = BoardThemeId.classic;
  AppTheme _theme = AppTheme.classic;

  BoardThemeId get themeId => _themeId;
  AppTheme get theme => _theme;

  Future<void> load() async {
    _themeId = await SettingsService.getBoardTheme();
    _theme = AppTheme.forId(_themeId);
    notifyListeners();
  }

  Future<void> setTheme(BoardThemeId id) async {
    if (_themeId == id) {
      return;
    }
    _themeId = id;
    _theme = AppTheme.forId(id);
    await SettingsService.setBoardTheme(id);
    notifyListeners();
  }
}
