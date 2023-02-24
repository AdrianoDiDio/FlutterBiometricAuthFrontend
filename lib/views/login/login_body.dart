import 'package:biometric_auth_frontend/biometrics/biometric_utils.dart';
import 'package:biometric_auth_frontend/failures/error_object.dart';
import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/localizations_ext.dart';
import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/providers/auth_provider.dart';
import 'package:biometric_auth_frontend/providers/biometric_provider.dart';
import 'package:biometric_auth_frontend/repositories/biometric_auth_repository.dart';
import 'package:biometric_auth_frontend/repositories/biometric_repository.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:biometric_auth_frontend/utils/dialog_utils.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:biometric_auth_frontend/views/login/login_form.dart';
import 'package:biometric_auth_frontend/views/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical * 8,
              horizontal: SizeConfig.blockSizeHorizontal * 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(S.of(context).loginScreenTitle,
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 8,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
                const LoginForm(),
                SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
                Visibility(
                    visible: Provider.of<BiometricProvider>(context)
                        .areBiometricsEnrolled,
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.fingerprint_rounded),
                        onPressed: () {
                          _attemptBiometricLogin(context);
                        },
                        label: Text(S.of(context).biometricLoginText))),
                SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
                ElevatedButton(
                    onPressed: () {
                      context.pushNamed(RegisterScreen.routeName);
                    },
                    child: Text(S.of(context).registerButton)),
              ],
            ),
          )),
    );
  }

  void _attemptBiometricLogin(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        });
    var biometricLoginResponse =
        await Provider.of<BiometricProvider>(context, listen: false)
            .login()
            .whenComplete(() => context.pop());
    biometricLoginResponse.fold((l) async {
      if (l is! BiometricDecryptCiphertextCancelled) {
        await DialogUtils.showErrorDialog(
            context, ErrorObject.mapFailureToErrorObject(failure: l).message);
      } else {
        logger.d("User cancelled it");
      }
    }, (r) {
      Provider.of<AuthProvider>(context, listen: false)
          .login(r.accessToken, r.refreshToken);
    });
  }
}
