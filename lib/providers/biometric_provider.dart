import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:flutter/material.dart';

class BiometricProvider with ChangeNotifier {
  late bool _biometricsEnrolled;

  bool get areBiometricsEnrolled => _biometricsEnrolled;

  BiometricProvider() {
    logger.d("Initialization...");
    _biometricsEnrolled = false;
    _init();
  }

  void _init() async {
    String? result = await serviceLocator
        .get<StorageUtils>()
        .read(StorageKeys.biometricsToken);
    _biometricsEnrolled = result != null;
    notifyListeners();
  }

  void enroll(String biometricToken, String privateKey, String userId) {
    serviceLocator
        .get<StorageUtils>()
        .write(StorageKeys.biometricsToken, biometricToken);
    serviceLocator
        .get<StorageUtils>()
        .write(StorageKeys.biometricsPrivateKey, privateKey);
    serviceLocator
        .get<StorageUtils>()
        .write(StorageKeys.biometricsUserId, userId);
    _biometricsEnrolled = true;
    notifyListeners();
  }

  void cancel() {
    serviceLocator.get<StorageUtils>().delete(StorageKeys.biometricsToken);
    serviceLocator.get<StorageUtils>().delete(StorageKeys.biometricsPrivateKey);
    serviceLocator.get<StorageUtils>().delete(StorageKeys.biometricsUserId);
    _biometricsEnrolled = false;
    notifyListeners();
  }
}
