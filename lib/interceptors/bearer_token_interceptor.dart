import 'package:biometric_auth_frontend/failures/error_object.dart';
import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/retrofit/repositories/auth_repository.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:dio/dio.dart';

class BearerTokenInterceptor extends Interceptor {
  final Dio dio;

  BearerTokenInterceptor(this.dio);
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers["No-Authentication"] == null) {
      logger.d("Authentication is required for this endpoint");
      String? accessToken = await serviceLocator
          .get<StorageUtils>()
          .read(StorageKeys.accessToken);
      if (accessToken != null) {
        options.headers["Authorization"] = "Bearer $accessToken";
      }
    } else {
      logger.d("No Auth needed...");
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null) {
      if (err.response!.statusCode == 401 &&
          err.requestOptions.headers["No-Authentication"] == null) {
        logger.d("Refreshing it...");
        String? refreshToken = await serviceLocator
            .get<StorageUtils>()
            .read(StorageKeys.refreshToken);
        if (refreshToken != null) {
          logger.d("Refreshing using $refreshToken");
          AuthRepositoryImplementation authRepositoryImplementation =
              AuthRepositoryImplementation();
          final result = await authRepositoryImplementation
              .refreshAccessToken(refreshToken);
          return result.fold((l) {
            logger.d(
                "Interceptor failed to refresh token ${ErrorObject.mapFailureToErrorObject(failure: l).message}");
            serviceLocator.get<StorageUtils>().delete(StorageKeys.refreshToken);
            serviceLocator.get<StorageUtils>().delete(StorageKeys.accessToken);
            return handler.next(err);
          }, (r) async {
            serviceLocator
                .get<StorageUtils>()
                .write(StorageKeys.accessToken, r.accessToken);
            err.requestOptions.headers["Authorization"] =
                "Bearer ${r.accessToken}";
            final opts = Options(
                method: err.requestOptions.method,
                headers: err.requestOptions.headers);
            final cloneReq = await dio.request(err.requestOptions.path,
                options: opts,
                data: err.requestOptions.data,
                queryParameters: err.requestOptions.queryParameters);
            return handler.resolve(cloneReq);
          });
        }
      }
    }
    return handler.next(err);
  }
}
