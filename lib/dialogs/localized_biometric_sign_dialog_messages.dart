import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:flutter_biometrics/dialog_messages.dart';

class LocalizedBiometricSignDialogMessages extends DialogMessages {
  LocalizedBiometricSignDialogMessages()
      : super(
          hint: S.current.biometricHint,
          notRecognized: S.current.biometricNotRecognized,
          success: S.current.biometricSuccess,
          cancel: S.current.biometricSignCancel,
          title: S.current.biometricTitle,
          requiredTitle: S.current.biometricTitle,
          settings: S.current.biometricSettingsRedirect,
          settingsDescription: S.current.biometricSettingsRedirectReason,
          lockOut: S.current.biometricLockOut,
          goToSettingsButton: S.current.biometricSettingsRedirect,
          goToSettingsDescription: S.current.biometricSettingsRedirectReason,
          cancelButton: S.current.biometricSignCancel,
        );
}
