import 'package:biometric_auth_frontend/retrofit/responses/biometric_challenge_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/biometric_token_response.dart';
import 'package:biometric_auth_frontend/retrofit/responses/login_response.dart';

abstract class BiometricService {
  Future<LoginResponse> biometricLogin(int userId, String biometricToken);
  Future<BiometricTokenChallengeResponse> getBiometricChallenge();
  Future<BiometricTokenResponse> getBiometricToken(
      String signedBiometricChallenge, int nonce, String publicKey);
}
