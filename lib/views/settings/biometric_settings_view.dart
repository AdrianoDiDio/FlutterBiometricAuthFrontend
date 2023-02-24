import 'dart:convert';
import 'dart:math';

import 'package:biometric_auth_frontend/biometrics/biometric_utils.dart';
import 'package:biometric_auth_frontend/failures/error_object.dart';
import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/providers/biometric_provider.dart';
import 'package:biometric_auth_frontend/repositories/biometric_auth_repository.dart';
import 'package:biometric_auth_frontend/repositories/biometric_repository.dart';
import 'package:biometric_auth_frontend/retrofit/responses/biometric_challenge_response.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:biometric_auth_frontend/utils/dialog_utils.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BiometricSettingsView extends StatelessWidget {
  static String routeName = "biometrics";
  static String routePath = "biometrics";

  const BiometricSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).biometricsScreenTitle),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).enableBiometricAuthenticationEntry,
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 3)),
                        Switch(
                          value: Provider.of<BiometricProvider>(context)
                              .areBiometricsEnrolled,
                          onChanged: (value) {
                            if (!value) {
                              logger.d("Removing biometric data...");
                              Provider.of<BiometricProvider>(context,
                                      listen: false)
                                  .cancel();
                            } else {
                              logger.d("Starting on-board process");
                              _enrollBiometricToken(context);
                            }
                          },
                        )
                      ])
                ]))));
  }

  void _enrollBiometricToken(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        });
    var biometricEnrollResponse =
        await Provider.of<BiometricProvider>(context, listen: false)
            .enroll()
            .whenComplete(() => context.pop());
    biometricEnrollResponse.fold((l) async {
      await DialogUtils.showErrorDialog(
          context, ErrorObject.mapFailureToErrorObject(failure: l).message);
    }, (r) {
      if (!r) {
        logger.d("User cancelled it...");
      }
    });
  }
}
