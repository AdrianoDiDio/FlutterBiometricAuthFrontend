import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const Failure._();
  const factory Failure.serverFailure() = ServerFailure;
  const factory Failure.loginFailure() = LoginFailure;
  const factory Failure.logoutFailure() = LogoutFailure;
  const factory Failure.refreshAccessTokenFailure() = RefreshAccessTokenFailure;
  const factory Failure.registrationEmailFailure() = RegistrationEmailFailure;
  const factory Failure.registrationPasswordFailure() =
      RegistrationPasswordFailure;
  const factory Failure.registrationUsernameFailure() =
      RegistrationUsernameFailure;
  const factory Failure.getBiometricTokenFailure() = GetBiometricTokenFailure;
  const factory Failure.unauthorizedFailure() = UnauthorizedFailure;
  const factory Failure.unknownFailure() = UnknownFailure;
}
