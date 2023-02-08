import 'package:biometric_auth_frontend/retrofit/responses/login_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/refresh_access_token_response.dart';

abstract class AuthService {
  Future<LoginResponse> login(String username, String password);
  Future<void> logout(String refreshToken);
  Future<RefreshAccessTokenResponse> refreshAccessToken(String refreshToken);
}
