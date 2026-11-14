import 'package:flutter/foundation.dart';

import 'Tools/purchase_service.dart';
import 'app_theme.dart';
import 'settings_service.dart';

/// Notifies the UI when the player changes board theme, or when a Premium
/// theme becomes available or unavailable with the Premium entitlement.
class ThemeController extends ChangeNotifier {
  ThemeController._() {
    PurchaseService.instance.addListener(_onEntitlementChanged);
  }
  static final ThemeController instance = ThemeController._();

  BoardThemeId _selected = BoardThemeId.classic;
  bool _premium = false;

  /// The theme in effect. A saved Premium theme falls back to Classic while
  /// Premium is not active, and returns as soon as it is.
  BoardThemeId get themeId => _selected.requiresPremium && !isPremiumUser
      ? BoardThemeId.classic
      : _selected;
  AppTheme get theme => AppTheme.forId(themeId);

  void _onEntitlementChanged() {
    final premium = isPremiumUser;
    if (premium == _premium) return;
    _premium = premium;
    if (_selected.requiresPremium) notifyListeners();
  }

  Future<void> load() async {
    _premium = isPremiumUser;
    _selected = await SettingsService.getBoardTheme();
    notifyListeners();
  }

  /// Returns false, without changing anything, for a Premium theme while
  /// Premium is not active.
  Future<bool> setTheme(BoardThemeId id) async {
    if (id.requiresPremium && !isPremiumUser) return false;
    if (_selected == id) return true;
    _selected = id;
    notifyListeners();
    await SettingsService.setBoardTheme(id);
    return true;
  }
}
