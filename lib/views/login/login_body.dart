import 'dart:convert';
import 'dart:typed_data';

import 'package:biometric_auth_frontend/biometrics/biometrics_utils.dart';
import 'package:biometric_auth_frontend/failures/error_object.dart';
import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/localizations_ext.dart';
import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/providers/auth_provider.dart';
import 'package:biometric_auth_frontend/providers/biometric_provider.dart';
import 'package:biometric_auth_frontend/retrofit/repositories/biometric_repository.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:biometric_auth_frontend/views/login/login_form.dart';
import 'package:biometric_auth_frontend/views/register/register_view.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_biometrics/flutter_biometrics.dart';
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
    StorageUtils storageUtils = serviceLocator.get<StorageUtils>();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        });
    String? biometricToken =
        await storageUtils.read(StorageKeys.biometricsToken);
    String? biometricUserId =
        await storageUtils.read(StorageKeys.biometricsUserId);
    String? biometricPrivateKey =
        await storageUtils.read(StorageKeys.biometricsPrivateKey);

    if (biometricToken != null &&
        biometricUserId != null &&
        biometricPrivateKey != null) {
      await FlutterBiometrics()
          .decrypt(
              ciphertext: biometricToken,
              reason: "Authenticated to decrypt the token")
          .then((value) async {
        BiometricRepositoryImplementation biometricRepositoryImplementation =
            BiometricRepositoryImplementation();
        var response = await biometricRepositoryImplementation
            .biometricLogin(int.parse(biometricUserId), value)
            .whenComplete(() => context.pop());
        response.fold((l) async {
          String error =
              ErrorObject.mapFailureToErrorObject(failure: l).message;
          logger.d(error);
          Provider.of<BiometricProvider>(context, listen: false).cancel();
          await _showErrorDialog(context, error);
        }, (r) {
          logger.d("Login successful...${r.accessToken}");
          Provider.of<AuthProvider>(context, listen: false)
              .login(r.accessToken, r.refreshToken);
        });
      });
    }
  }

  Future<void> _showErrorDialog(BuildContext context, String message) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).dialogErrorTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).dialogOkButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
