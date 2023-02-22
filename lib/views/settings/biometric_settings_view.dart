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
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_biometrics/flutter_biometrics.dart';
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

  void _enrollBiometricFailed(BuildContext context) {
    context.pop();
  }

  void _enrollBiometricToken(BuildContext context) async {
    BiometricRepositoryImplementation biometricRepositoryImplementation =
        BiometricRepositoryImplementation();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        });
    BiometricAuthRepositoryImplementation
        biometricAuthRepositoryImplementation =
        BiometricAuthRepositoryImplementation(
            biometric: FlutterBiometricsImplementation());
    var createKeyResponse =
        await biometricAuthRepositoryImplementation.generateKeys();
    createKeyResponse.fold((generateKeysFailure) {
      ErrorObject errorObject =
          ErrorObject.mapFailureToErrorObject(failure: generateKeysFailure);
      logger.d("Couldn't generate a keypair...${errorObject.message}");
      _enrollBiometricFailed(context);
    }, (publicKey) async {
      Either<Failure, BiometricTokenChallengeResponse>
          biometricChallengeResponse =
          await biometricRepositoryImplementation.getBiometricChallenge();
      biometricChallengeResponse.fold((challengeFailure) {
        ErrorObject errorObject =
            ErrorObject.mapFailureToErrorObject(failure: challengeFailure);
        logger.d("Couldn't generate a challenge...${errorObject.message}");
        _enrollBiometricFailed(context);
      }, (r) async {
        String decodedChallenge =
            utf8.decode(base64Decode(r.biometricChallenge));
        logger.d(
            "Got challenge ${r.biometricChallenge} decoded to $decodedChallenge");
        logger.d("Next step!");
        Random random = Random();
        var nonce = random.nextInt(4294967296);
        String encodedChallengeWithNonce =
            base64.encode(utf8.encode(decodedChallenge + nonce.toString()));
        //Generate RSA key-pair
        var signPayloadResponse =
            await biometricAuthRepositoryImplementation.signPayload(
                encodedChallengeWithNonce, S.current.biometricSignReason);
        signPayloadResponse.fold((signFailure) {
          logger.d(
              "Signing failed...${ErrorObject.mapFailureToErrorObject(failure: signFailure).message}");
          _enrollBiometricFailed(context);
        }, (signedChallenge) async {
          var biometricTokenResponse = await biometricRepositoryImplementation
              .getBiometricToken(signedChallenge, nonce, publicKey)
              .whenComplete(() => context.pop());
          biometricTokenResponse.fold((l) {
            logger.d(
                "Error:${ErrorObject.mapFailureToErrorObject(failure: l).message}");
          }, (r) {
            Provider.of<BiometricProvider>(context, listen: false)
                .enroll(r.biometricToken, "biometric", r.userId);
          });
        });
      });
    });
  }
}
