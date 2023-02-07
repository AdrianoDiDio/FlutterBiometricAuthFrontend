import 'dart:io';

import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;
  LanguageProvider() {
    logger.d("Initialization...");
    _locale = null;
    _init();
  }

  _init() async {
    StorageUtils storageUtils = StorageUtils();
    String? result = await storageUtils.read(StorageKeys.localeName);
    if (result != null) {
      logger.d(result);
      _locale = Locale(result);
    }
    notifyListeners();
  }

  set locale(Locale? locale) {
    _locale = locale;
    StorageUtils storageUtils = StorageUtils();
    storageUtils.write(StorageKeys.localeName, _locale!.languageCode);
    notifyListeners();
  }
}
