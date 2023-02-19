import 'package:biometric_auth_frontend/logger.dart';
import 'package:flutter_biometrics/flutter_biometrics.dart';
import 'package:local_auth/local_auth.dart';

class BiometricUtils {
  late bool _biometricSupported;

  bool get biometricSupported => _biometricSupported;

  BiometricUtils() {
    _init();
  }

  void _init() async {
    logger.d("BiometricUtils initialization...");
    _biometricSupported = await isBiometricSupported();
    logger.d("Device is supported $_biometricSupported");
  }

  Future<bool> isBiometricSupported() async {
    FlutterBiometrics flutterBiometrics = FlutterBiometrics();
    return await flutterBiometrics.authAvailable;
  }
}
