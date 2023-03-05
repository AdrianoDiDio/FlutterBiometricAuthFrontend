import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:flutter/material.dart';

import '../locator.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  static String themModeToName(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return S.current.settingsScreenThemeSystemEntry;
      case ThemeMode.light:
        return S.current.settingsScreenThemeLightEntry;
      case ThemeMode.dark:
        return S.current.settingsScreenThemeDarkEntry;
      default:
        return "Unknown theme";
    }
  }

  String get themeModeName {
    return themModeToName(_themeMode);
  }

  ThemeProvider(String? initialTheme) {
    logger.d("Initialization...");
    _init(initialTheme);
  }

  _init(String? initialTheme) {
    if (initialTheme != null) {
      logger.d(initialTheme);
      _themeMode = ThemeMode.values.byName(initialTheme);
    } else {
      _themeMode = ThemeMode.system;
      serviceLocator
          .get<StorageUtils>()
          .write(StorageKeys.themeMode, _themeMode.name);
    }
    notifyListeners();
  }

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    serviceLocator
        .get<StorageUtils>()
        .write(StorageKeys.themeMode, _themeMode.name);
    notifyListeners();
  }
}
