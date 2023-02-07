import 'package:biometric_auth_frontend/retrofit/responses/login_response.dart';

abstract class AuthService {
  Future<LoginResponse> login(String username, String password);
}
