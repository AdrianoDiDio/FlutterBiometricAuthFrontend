import 'package:biometric_auth_frontend/biometrics/biometric_utils.dart';
import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:dartz/dartz.dart';

abstract class BiometricAuthRepository {
  Biometric biometric;
  BiometricAuthRepository({required this.biometric});
  Future<Either<Failure, String>> generateKeys();
  Future<Either<Failure, String>> signPayload(String payload, String reason);
  Future<Either<Failure, String>> decryptCiphertext(
      String ciphertext, String reason);
  Future<Either<Failure, bool>> deleteKeys();
}

class BiometricAuthRepositoryImplementation extends BiometricAuthRepository {
  BiometricAuthRepositoryImplementation({required super.biometric});
  @override
  Future<Either<Failure, String>> generateKeys() async {
    try {
      final response = await biometric.generateKeys();
      return Right(response);
    } on Error {
      return const Left(Failure.biometricGenerateKeysFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteKeys() async {
    try {
      final response = await biometric.deleteKeys();
      return Right(response);
    } on Error {
      return const Left(Failure.biometricGenerateKeysFailure());
    }
  }

  @override
  Future<Either<Failure, String>> signPayload(
      String payload, String reason) async {
    try {
      final response = await biometric.signPayload(payload, reason);
      if (response is bool) {
        return const Left(Failure.biometricSignPayloadCancelled());
      }
      return Right(response);
    } on Error {
      return const Left(Failure.biometricSignPayloadFailure());
    }
  }

  @override
  Future<Either<Failure, String>> decryptCiphertext(
      String ciphertext, String reason) async {
    try {
      dynamic response = await biometric.decryptCiphertex(ciphertext, reason);
      if (response is bool) {
        return const Left(Failure.biometricDecryptCiphertextCancelled());
      }
      return Right(response as String);
    } on Error catch (e) {
      logger.d(e.toString());
      return const Left(Failure.biometricDecryptCiphertextFailure());
    }
  }
}
