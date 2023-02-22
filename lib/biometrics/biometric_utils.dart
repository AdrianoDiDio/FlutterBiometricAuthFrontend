import 'package:biometric_auth_frontend/dialogs/localized_biometric_login_dialog_messages.dart';
import 'package:biometric_auth_frontend/dialogs/localized_biometric_sign_dialog_messages.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:flutter_biometrics/flutter_biometrics.dart';

abstract class Biometric {
  late bool _biometricSupported;

  bool get biometricSupported => _biometricSupported;

  Future<bool> isBiometricSupported();
  Future<dynamic> generateKeys();
  Future<dynamic> deleteKeys();
  Future<dynamic> signPayload(String payload, String reason);
  Future<dynamic> decryptCiphertex(String ciphertext, String reason);
}

class FlutterBiometricsImplementation extends Biometric {
  late FlutterBiometrics flutterBiometrics;
  FlutterBiometricsImplementation() {
    _init();
  }

  void _init() async {
    logger.d("BiometricImplementation initialization...");
    flutterBiometrics = FlutterBiometrics();
    _biometricSupported = await isBiometricSupported();
    logger.d("Device is supported $_biometricSupported");
  }

  @override
  Future<bool> isBiometricSupported() async {
    return await flutterBiometrics.authAvailable;
  }

  @override
  Future<dynamic> generateKeys() async {
    return await flutterBiometrics.createKeys();
  }

  @override
  Future<dynamic> deleteKeys() async {
    return await flutterBiometrics.deleteKeys();
  }

  @override
  Future<dynamic> signPayload(String payload, String reason) async {
    return await flutterBiometrics.sign(
        payload: payload,
        reason: reason,
        dialogMessages: LocalizedBiometricSignDialogMessages());
  }

  @override
  Future<dynamic> decryptCiphertex(String ciphertext, String reason) async {
    return await flutterBiometrics.decrypt(
        ciphertext: ciphertext,
        reason: reason,
        dialogMessages: LocalizedBiometricLoginDialogMessages());
  }
}
