import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/retrofit/repositories/base_repository.dart';
import 'package:biometric_auth_frontend/retrofit/responses/biometric_challenge_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/biometric_token_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/login_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class BiometricRepository {
  Future<Either<Failure, LoginResponse>> biometricLogin(
      int userId, String biometricToken);
  Future<Either<Failure, BiometricTokenResponse>> getBiometricToken(
      String signedBiometricChallenge, int nonce, String publicKey);

  Future<Either<Failure, BiometricTokenChallengeResponse>>
      getBiometricChallenge();
}

class BiometricRepositoryImplementation extends BaseRepository
    implements BiometricRepository {
  @override
  Future<Either<Failure, BiometricTokenChallengeResponse>>
      getBiometricChallenge() async {
    try {
      final response = await restClient.getBiometricChallenge();
      return Right(response);
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        return const Left(Failure.unauthorizedFailure());
      }
      return const Left(Failure.serverFailure());
    } catch (e) {
      return const Left(Failure.unknownFailure());
    }
  }

  @override
  Future<Either<Failure, BiometricTokenResponse>> getBiometricToken(
      String signedBiometricChallenge, int nonce, String publicKey) async {
    try {
      final response = await restClient.getBiometricToken(
          signedBiometricChallenge, nonce, publicKey);
      return Right(response);
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          return const Left(Failure.unauthorizedFailure());
        } else if (e.response!.statusCode == 400) {
          return const Left(Failure.getBiometricTokenFailure());
        }
      }
      return const Left(Failure.serverFailure());
    } catch (e) {
      return const Left(Failure.unknownFailure());
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> biometricLogin(
      int userId, String biometricToken) async {
    try {
      final response = await restClient.biometricLogin(userId, biometricToken);
      return Right(response);
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          return const Left(Failure.loginFailure());
        }
      }
      return const Left(Failure.serverFailure());
    } catch (e) {
      return const Left(Failure.unknownFailure());
    }
  }
}
