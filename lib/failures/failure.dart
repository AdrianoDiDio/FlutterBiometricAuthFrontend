import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const Failure._();
  const factory Failure.serverFailure() = ServerFailure;
  const factory Failure.loginFailure() = LoginFailure;
  const factory Failure.biometricTokenLoginFailure() =
      BiometricTokenLoginFailure;
  const factory Failure.logoutFailure() = LogoutFailure;
  const factory Failure.refreshAccessTokenFailure() = RefreshAccessTokenFailure;
  const factory Failure.registrationEmailFailure() = RegistrationEmailFailure;
  const factory Failure.registrationPasswordFailure() =
      RegistrationPasswordFailure;
  const factory Failure.registrationUsernameFailure() =
      RegistrationUsernameFailure;
  const factory Failure.getBiometricTokenFailure() = GetBiometricTokenFailure;
  const factory Failure.unauthorizedFailure() = UnauthorizedFailure;
  const factory Failure.decryptRSAFailure() = DecryptRSAFailure;
  const factory Failure.biometricGenerateKeysFailure() =
      BiometricGenerateKeysFailure;
  const factory Failure.biometricSignPayloadFailure() =
      BiometricSignPayloadFailure;
  const factory Failure.biometricDecryptCiphertextFailure() =
      BiometricDecryptCiphertexFailure;
  const factory Failure.biometricDecryptCiphertextCancelled() =
      BiometricDecryptCiphertextCancelled;
  const factory Failure.unknownFailure() = UnknownFailure;
}
