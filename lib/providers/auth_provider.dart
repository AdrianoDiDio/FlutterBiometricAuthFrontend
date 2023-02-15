import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  late bool _loggedIn;

  bool get isLoggedIn => _loggedIn;

  AuthProvider() {
    logger.d("Initialization...");
    _loggedIn = false;
    _init();
  }

  _init() async {
    String? result =
        await serviceLocator.get<StorageUtils>().read(StorageKeys.accessToken);
    _loggedIn = result != null;
    notifyListeners();
  }

  void login(String accessToken, String refreshToken) {
    serviceLocator
        .get<StorageUtils>()
        .write(StorageKeys.accessToken, accessToken);
    serviceLocator
        .get<StorageUtils>()
        .write(StorageKeys.refreshToken, refreshToken);
    _loggedIn = true;
    notifyListeners();
  }

  void logout() {
    serviceLocator.get<StorageUtils>().delete(StorageKeys.accessToken);
    serviceLocator.get<StorageUtils>().delete(StorageKeys.refreshToken);
    _loggedIn = false;
    notifyListeners();
  }
}
