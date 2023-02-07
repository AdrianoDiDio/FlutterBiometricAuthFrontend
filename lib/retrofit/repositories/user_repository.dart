import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/retrofit/repositories/base_repository.dart';
import 'package:biometric_auth_frontend/retrofit/responses/register_failure_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/register_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/user_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class UserRepository {
  Future<Either<Failure, RegisterResponse>> register(
      String username, String email, String password);
  Future<Either<Failure, UserResponse>> getUserDetails();
}

class UserRepositoryImplementation extends BaseRepository
    implements UserRepository {
  UserRepositoryImplementation({super.restClient});

  @override
  Future<Either<Failure, RegisterResponse>> register(
      String username, String email, String password) async {
    try {
      final response = await restClient.register(username, email, password);
      return Right(response);
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        RegisterFailureResponse registerResponse =
            RegisterFailureResponse.fromJson(e.response!.data);
        if (registerResponse.email != null) {
          return const Left(RegistrationEmailFailure());
        } else if (registerResponse.username != null) {
          return const Left(RegistrationUsernameFailure());
        } else if (registerResponse.password != null) {
          return const Left(RegistrationPasswordFailure());
        } else {
          return const Left(ServerFailure());
        }
      }
    } catch (e) {
      return const Left(ServerFailure());
    }
    return const Left(UnknownFailure());
  }

  @override
  Future<Either<Failure, UserResponse>> getUserDetails() async {
    try {
      final response = await restClient.getUserDetails();
      return Right(response);
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        return const Left(UnauthorizedFailure());
      } else {
        return const Left(ServerFailure());
      }
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
