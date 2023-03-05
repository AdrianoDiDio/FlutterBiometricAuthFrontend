import 'package:biometric_auth_frontend/biometrics/biometric_utils.dart';
import 'package:biometric_auth_frontend/interceptors/bearer_token_interceptor.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/retrofit/rest_client.dart';
import 'package:biometric_auth_frontend/retrofit/rest_endpoints.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;
void setUpSingletons() {
  final dio = Dio()..options = BaseOptions(baseUrl: RestEndpoints.baseURL);
  dio.interceptors.addAll([
    PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
        logPrint: logger.d),
    BearerTokenInterceptor(dio)
  ]);
  serviceLocator.registerLazySingleton<RestClient>(() => RestClient(dio));
  serviceLocator.registerLazySingleton<StorageUtils>(() => StorageUtils());
  serviceLocator.registerSingleton<FlutterBiometricsImplementation>(
      FlutterBiometricsImplementation());
}
