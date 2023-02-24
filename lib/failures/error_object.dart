import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/localizations_ext.dart';

class ErrorObject {
  final String title;
  final String message;
  ErrorObject({required this.title, required this.message});

  static ErrorObject mapFailureToErrorObject({required Failure failure}) {
    return failure.when(
      serverFailure: () => ErrorObject(
        title: 'Error Code: INTERNAL_SERVER_FAILURE',
        message: S.current.serverFailure,
      ),
      loginFailure: () => ErrorObject(
          title: 'Error Code: WRONG_ACCOUNT_CREDENTIALS',
          message: S.current.loginFailed),
      registrationEmailFailure: () => ErrorObject(
          title: 'REGISTRATION_EMAIL_ALREADY_IN_USE',
          message: S.current.emailAlreadyInUse),
      registrationPasswordFailure: () => ErrorObject(
          title: 'REGISTRATION_PASSWORD_TOO_COMMON',
          message: S.current.passwordTooCommon),
      registrationUsernameFailure: () => ErrorObject(
          title: 'REGISTRATION_USERNAME_NOT_UNIQUE',
          message: S.current.usernameNotUnique),
      unknownFailure: () => ErrorObject(
          title: "Error Code: UNKNOWN_ERROR", message: S.current.unknownError),
      unauthorizedFailure: () => ErrorObject(
          title: "Error Code: UNAUTHORIZED_ERROR",
          message: S.current.unauthorizedError),
      biometricTokenLoginFailure: () => ErrorObject(
          title: "Error Code: INVALID_BIOMETRIC_TOKEN",
          message: S.current.invalidBiometricToken),
      getBiometricTokenFailure: () => ErrorObject(
          title: "Error Code: GENERATE_BIOMETRIC_TOKEN_FAILURE",
          message: S.current.getBiometricTokenFailure),
      refreshAccessTokenFailure: () => ErrorObject(
          title: "Error Code: REFRESH_ACCESS_TOKEN_FAILURE",
          message: S.current.refreshAccessTokenFailure),
      decryptRSAFailure: () => ErrorObject(
          title: "Error Code: RSA_DECRIPTION_FAILURE",
          message: S.current.decryptRSAFailure),
      biometricGenerateKeysFailure: () => ErrorObject(
          title: "Error Code: BIOMETRIC_GENERATE_KEY_ERROR",
          message: S.current.biometricGenerateKeysFailure),
      biometricSignPayloadFailure: () => ErrorObject(
          title: "Error Code: BIOMETRIC_SIGN_PAYLOAD_ERROR",
          message: S.current.biometricSignPayloadFailure),
      biometricDecryptCiphertextFailure: () => ErrorObject(
          title: "Error Code: BIOMETRIC_DECRYPT_CIPHERTEXT_ERROR",
          message: S.current.biometricDecryptCiphertextFailure),
      biometricDecryptCiphertextCancelled: () => ErrorObject(
          title: "Error Code: BIOMETRIC_DECRYPT_CIPHERTEXT_CANCELLED",
          message: S.current.biometricDecryptCiphertextCancelled),
      biometricSignPayloadCancelled: () => ErrorObject(
          title: "Error Code: BIOMETRIC_SIGN_PAYLOAD_CANCELLED",
          message: S.current.biometricSignPayloadCancelled),
      biometricUserNotEnrolledFailure: () => ErrorObject(
          title: "Error Code: BIOMETRIC_USER_NOT_ENROLLED",
          message: S.current.biometricUserNotEnrolledFailure),
      logoutFailure: () => ErrorObject(
          title: "Error Code: LOGOUT_FAILED", message: S.current.logoutFailure),
    );
  }
}
