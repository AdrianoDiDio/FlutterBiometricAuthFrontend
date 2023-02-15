import 'package:biometric_auth_frontend/retrofit/responses/biometric_challenge_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/biometric_token_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/login_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/refresh_access_token_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/register_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/user_response.dart';
import 'package:biometric_auth_frontend/retrofit/rest_endpoints.dart';
import 'package:biometric_auth_frontend/retrofit/services/auth_service.dart';
import 'package:biometric_auth_frontend/retrofit/services/biometric_service.dart';
import 'package:biometric_auth_frontend/retrofit/services/user_service.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient
    implements AuthService, UserService, BiometricService {
  factory RestClient(Dio dio) = _RestClient;

  @override
  @POST(RestEndpoints.login)
  @Headers(<String, dynamic>{"No-Authentication": "true"})
  Future<LoginResponse> login(
      @Field("username") String username, @Field("password") String password);

  @override
  @POST(RestEndpoints.biometricLogin)
  @Headers(<String, dynamic>{"No-Authentication": "true"})
  Future<LoginResponse> biometricLogin(@Field("userId") int userId,
      @Field("biometricToken") String biometricToken);

  @override
  @POST(RestEndpoints.logout)
  Future<void> logout(@Field("refresh") String refreshToken);

  @override
  @POST(RestEndpoints.register)
  @FormUrlEncoded()
  @Headers(<String, dynamic>{"No-Authentication": "true"})
  Future<RegisterResponse> register(@Field("username") String username,
      @Field("email") String email, @Field("password") String password);

  @override
  @GET(RestEndpoints.userDetails)
  Future<UserResponse> getUserDetails();

  @override
  @POST(RestEndpoints.refreshAccessToken)
  @FormUrlEncoded()
  @Headers(<String, dynamic>{"No-Authentication": "true"})
  Future<RefreshAccessTokenResponse> refreshAccessToken(
      @Field("refresh") String refreshToken);

  @override
  @POST("getBiometricToken")
  @FormUrlEncoded()
  Future<BiometricTokenResponse> getBiometricToken(
      @Field("signedBiometricChallenge") String signedBiometricChallenge,
      @Field("nonce") int nonce,
      @Field("publicKey") String publicKey);
  @override
  @GET("getBiometricChallenge")
  Future<BiometricTokenChallengeResponse> getBiometricChallenge();
}
