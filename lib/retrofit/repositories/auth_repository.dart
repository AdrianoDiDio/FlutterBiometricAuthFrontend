import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/retrofit/repositories/base_repository.dart';
import 'package:biometric_auth_frontend/retrofit/responses/login_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/refresh_access_token_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(
      String username, String password);
  Future<Either<Failure, RefreshAccessTokenResponse>> refreshAccessToken(
      String refreshToken);
}

class AuthRepositoryImplementation extends BaseRepository
    implements AuthRepository {
  AuthRepositoryImplementation({super.restClient});

  @override
  Future<Either<Failure, LoginResponse>> login(
      String username, String password) async {
    try {
      final response = await restClient.login(username, password);
      return Right(response);
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        return const Left(Failure.loginFailure());
      }
    } catch (e) {
      return const Left(Failure.serverFailure());
    }
    return const Left(Failure.unknownFailure());
  }

  @override
  Future<Either<Failure, RefreshAccessTokenResponse>> refreshAccessToken(
      String refreshToken) async {
    try {
      final response = await restClient.refreshAccessToken(refreshToken);
      return Right(response);
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        return const Left(Failure.refreshAccessTokenFailure());
      }
    } catch (e) {
      return const Left(Failure.serverFailure());
    }
    return const Left(Failure.unknownFailure());
  }
}
