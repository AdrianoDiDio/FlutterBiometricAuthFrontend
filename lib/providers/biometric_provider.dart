import 'dart:convert';
import 'dart:math';

import 'package:biometric_auth_frontend/biometrics/biometric_utils.dart';
import 'package:biometric_auth_frontend/failures/error_object.dart';
import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/repositories/biometric_auth_repository.dart';
import 'package:biometric_auth_frontend/repositories/biometric_repository.dart';
import 'package:biometric_auth_frontend/retrofit/responses/biometric_challenge_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/biometric_token_response.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:dartz/dartz.dart';
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

  Future<String?> _getBiometricChallenge(
      BiometricRepositoryImplementation biometricRepository) async {
    return await biometricRepository
        .getBiometricChallenge()
        .then((value) => value.fold((l) => null, (r) => r.biometricChallenge));
  }

  Future<BiometricTokenResponse?> _getBiometricToken(
      BiometricRepositoryImplementation biometricRepository,
      String signedBiometricChallenge,
      int nonce,
      String publicKey) async {
    return await biometricRepository
        .getBiometricToken(signedBiometricChallenge, nonce, publicKey)
        .then((value) => value.fold((l) => null, (r) => r));
  }

  Future<String?> _signPayload(
      BiometricAuthRepositoryImplementation biometricAuthRepository,
      String encodedChallengeWithNonce) async {
    return await biometricAuthRepository
        .signPayload(encodedChallengeWithNonce, S.current.biometricSignReason)
        .then((value) => value.fold((l) => null, (r) => r));
  }

  Future<String?> _getPublicKey(
      BiometricAuthRepositoryImplementation biometricAuthRepository) async {
    return await biometricAuthRepository
        .generateKeys()
        .then((value) => value.fold((l) => null, (r) => r));
  }

  Future<void> enroll() async {
    BiometricRepositoryImplementation biometricRepositoryImplementation =
        BiometricRepositoryImplementation();
    BiometricAuthRepositoryImplementation
        biometricAuthRepositoryImplementation =
        BiometricAuthRepositoryImplementation(
            biometric: FlutterBiometricsImplementation());
    _biometricsEnrolled = false;
    String? publicKey =
        await _getPublicKey(biometricAuthRepositoryImplementation);
    if (publicKey != null) {
      String? biometricChallenge =
          await _getBiometricChallenge(biometricRepositoryImplementation);
      if (biometricChallenge != null) {
        String decodedChallenge = utf8.decode(base64Decode(biometricChallenge));
        logger.d(
            "Got challenge $biometricChallenge decoded to $decodedChallenge");
        logger.d("Next step!");
        Random random = Random();
        var nonce = random.nextInt(4294967296);
        String encodedChallengeWithNonce =
            base64.encode(utf8.encode(decodedChallenge + nonce.toString()));
        //Generate RSA key-pair
        var signPayloadResponse = await _signPayload(
            biometricAuthRepositoryImplementation, encodedChallengeWithNonce);
        if (signPayloadResponse != null) {
          var biometricTokenResponse = await _getBiometricToken(
              biometricRepositoryImplementation,
              signPayloadResponse,
              nonce,
              publicKey);
          if (biometricTokenResponse != null) {
            serviceLocator.get<StorageUtils>().write(
                StorageKeys.biometricsToken,
                biometricTokenResponse.biometricToken);
            serviceLocator.get<StorageUtils>().write(
                StorageKeys.biometricsUserId, biometricTokenResponse.userId);
            _biometricsEnrolled = true;
          }
        }
      }
    }
    notifyListeners();
  }

  void cancel() {
    serviceLocator.get<FlutterBiometricsImplementation>().deleteKeys();
    serviceLocator.get<StorageUtils>().delete(StorageKeys.biometricsToken);
    serviceLocator.get<StorageUtils>().delete(StorageKeys.biometricsUserId);
    _biometricsEnrolled = false;
    notifyListeners();
  }
}
