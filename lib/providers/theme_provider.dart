import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;
  ThemeProvider() {
    logger.d("Initialization...");
    _themeMode = ThemeMode.system;
    _init();
  }

  _init() async {
    StorageUtils storageUtils = StorageUtils();
    String? result = await storageUtils.read(StorageKeys.themeMode);
    if (result != null) {
      logger.d(result);
      _themeMode = ThemeMode.values.byName(result);
    } else {
      storageUtils.write(StorageKeys.themeMode, _themeMode.name);
    }
    notifyListeners();
  }

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    StorageUtils storageUtils = StorageUtils();
    storageUtils.write(StorageKeys.themeMode, _themeMode.name);
    notifyListeners();
  }
}
