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
        message: 'It seems that the server is not reachable at the moment, try '
            'again later, should the issue persist please reach out to the '
            'developer at a@b.com',
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
          title: "Error Code: UNKNOWN_ERROR",
          message: 'An unknown error has occurred.'),
      unauthorizedFailure: () => ErrorObject(
          title: "Error Code: UNAUTHORIZED_ERROR",
          message: S.current.unauthorizedError),
      refreshAccessTokenFailure: () => ErrorObject(
          title: "Error Code: REFRESH_ACCESS_TOKEN_FAILURE",
          message: S.current.refreshAccessTokenFailure),
      noConnectionFailure: () => ErrorObject(
        title: 'Error Code: NO_CONNECTIVITY',
        message: 'It seems that your device is not connected to the network, '
            'please check your internet connectivity or try again later.',
      ),
    );
  }
}
