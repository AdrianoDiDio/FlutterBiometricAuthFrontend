import 'package:biometric_auth_frontend/retrofit/responses/register_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/user_response.dart';

abstract class UserService {
  Future<RegisterResponse> register(
      String username, String email, String password);
  Future<UserResponse> getUserDetails();
}
