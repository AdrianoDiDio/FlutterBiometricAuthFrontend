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
import 'package:biometric_auth_frontend/retrofit/responses/login_response.dart';
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

  Future<Either<Failure, String>> _getBiometricChallenge(
      BiometricRepositoryImplementation biometricRepository) async {
    var biometricChallengeResponse =
        await biometricRepository.getBiometricChallenge();
    return biometricChallengeResponse.fold(
        (l) => Left(l), (r) => Right(r.biometricChallenge));
  }

  Future<Either<Failure, BiometricTokenResponse>> _getBiometricToken(
      BiometricRepositoryImplementation biometricRepository,
      String signedBiometricChallenge,
      int nonce,
      String publicKey) async {
    var biometricTokenResponse = await biometricRepository.getBiometricToken(
        signedBiometricChallenge, nonce, publicKey);
    return biometricTokenResponse.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Failure, String>> _signPayload(
      BiometricAuthRepositoryImplementation biometricAuthRepository,
      String encodedChallengeWithNonce) async {
    var signPayloadResponse = await biometricAuthRepository.signPayload(
        encodedChallengeWithNonce, S.current.biometricSignReason);
    return signPayloadResponse.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Failure, String>> _getPublicKey(
      BiometricAuthRepositoryImplementation biometricAuthRepository) async {
    var generateKeysResponse = await biometricAuthRepository.generateKeys();
    return generateKeysResponse.fold((l) => Left(l), (r) => Right(r));
  }

  Future<Either<Failure, bool>> enroll() async {
    BiometricRepositoryImplementation biometricRepositoryImplementation =
        BiometricRepositoryImplementation();
    BiometricAuthRepositoryImplementation
        biometricAuthRepositoryImplementation =
        BiometricAuthRepositoryImplementation(
            biometric: FlutterBiometricsImplementation());
    _biometricsEnrolled = false;
    var publicKey = await _getPublicKey(biometricAuthRepositoryImplementation);
    return publicKey.fold((publicKeyFailure) => Left(publicKeyFailure),
        (publicKey) async {
      var biometricChallenge =
          await _getBiometricChallenge(biometricRepositoryImplementation);
      return biometricChallenge
          .fold((biometricChallengeFailure) => Left(biometricChallengeFailure),
              (biometricChallenge) async {
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
        return signPayloadResponse.fold((signPayloadFailure) {
          if (signPayloadFailure is BiometricSignPayloadCancelled) {
            return const Right(false);
          }
          return Left(signPayloadFailure);
        }, (signPayloadResponse) async {
          var biometricTokenResponse = await _getBiometricToken(
              biometricRepositoryImplementation,
              signPayloadResponse,
              nonce,
              publicKey);
          return biometricTokenResponse.fold(
              (biometricTokenResponseFailure) =>
                  Left(biometricTokenResponseFailure),
              (biometricTokenResponse) async {
            serviceLocator.get<StorageUtils>().write(
                StorageKeys.biometricsToken,
                biometricTokenResponse.biometricToken);
            serviceLocator.get<StorageUtils>().write(
                StorageKeys.biometricsUserId, biometricTokenResponse.userId);
            _biometricsEnrolled = true;
            notifyListeners();
            return const Right(true);
          });
        });
      });
    });
  }

  Future<Either<Failure, LoginResponse>> login() async {
    StorageUtils storageUtils = serviceLocator.get<StorageUtils>();
    String? biometricToken =
        await storageUtils.read(StorageKeys.biometricsToken);
    String? biometricUserId =
        await storageUtils.read(StorageKeys.biometricsUserId);
    if (biometricToken != null && biometricUserId != null) {
      BiometricAuthRepositoryImplementation
          biometricAuthRepositoryImplementation =
          BiometricAuthRepositoryImplementation(
              biometric: serviceLocator.get<FlutterBiometricsImplementation>());
      var decryptTokenResponse = await biometricAuthRepositoryImplementation
          .decryptCiphertext(biometricToken, S.current.biometricLoginText);
      return decryptTokenResponse.fold((l) => Left(l), (plaintext) async {
        BiometricRepositoryImplementation biometricRepositoryImplementation =
            BiometricRepositoryImplementation();
        var response = await biometricRepositoryImplementation.biometricLogin(
            int.parse(biometricUserId), plaintext);
        return response.fold((l) => Left(l), (r) => Right(r));
      });
    } else {
      return const Left(Failure.biometricUserNotEnrolledFailure());
    }
  }

  void cancel() {
    serviceLocator.get<FlutterBiometricsImplementation>().deleteKeys();
    serviceLocator.get<StorageUtils>().delete(StorageKeys.biometricsToken);
    serviceLocator.get<StorageUtils>().delete(StorageKeys.biometricsUserId);
    _biometricsEnrolled = false;
    notifyListeners();
  }
}
