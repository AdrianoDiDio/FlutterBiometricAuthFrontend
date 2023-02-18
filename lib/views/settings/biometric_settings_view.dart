import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:biometric_auth_frontend/biometrics/biometrics_utils.dart';
import 'package:biometric_auth_frontend/failures/error_object.dart';
import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/providers/biometric_provider.dart';
import 'package:biometric_auth_frontend/retrofit/repositories/biometric_repository.dart';
import 'package:biometric_auth_frontend/retrofit/responses/biometric_challenge_response.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pointycastle/export.dart' hide State, Padding;
import 'package:provider/provider.dart';
import 'package:flutter_biometrics/flutter_biometrics.dart';

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
                              // setState(() {
                              //   _biometricStatus = false;
                              // });
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
    // setState(() {
    //   _biometricStatus = false;
    // });
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
    await FlutterBiometrics().deleteKeys().then((value) => logger.d(value));
    logger.d("Deleted previous keys");
    Either<Failure, BiometricTokenChallengeResponse>
        biometricChallengeResponse =
        await biometricRepositoryImplementation.getBiometricChallenge();
    biometricChallengeResponse.fold((l) {
      ErrorObject errorObject = ErrorObject.mapFailureToErrorObject(failure: l);
      logger.d("Couldn't generate a challenge...${errorObject.message}");
      _enrollBiometricFailed(context);
    }, (r) async {
      String decodedChallenge = utf8.decode(base64Decode(r.biometricChallenge));
      logger.d(
          "Got challenge ${r.biometricChallenge} decoded to $decodedChallenge");
      logger.d("Next step!");
      Random random = Random();
      var nonce = random.nextInt(4294967296);
      String decodedChallengeWithNonce = decodedChallenge + nonce.toString();
      //Generate RSA key-pair
      FlutterBiometrics()
          .createKeys(reason: "Authenticate to create keys")
          .then((publicKey) {
        FlutterBiometrics()
            .sign(
                payload: base64.encode(utf8.encode(decodedChallengeWithNonce)),
                reason: "Authenticate to sign the string")
            .then((signedChallenge) async {
          // BiometricUtils.generateRSAKeyPair().then((value) async {
          // logger.d(
          // "Public Key:${BiometricUtils.encodePublicKeyToPemPKCS1(value.publicKey as RSAPublicKey)}");
          logger.d("Nonce:$nonce");
          // RSASignature sign = BiometricUtils.signRSA(
          //     value.privateKey as RSAPrivateKey,
          //     Uint8List.fromList(decodedChallengeWithNonce.codeUnits));
          // final sentSign = base64Encode(sign.bytes);
          // logger.d("sign $sentSign");
          var biometricTokenResponse = await biometricRepositoryImplementation
              .getBiometricToken(signedChallenge, nonce, publicKey);
          biometricTokenResponse.fold((l) {
            _enrollBiometricFailed(context);
            logger.d(
                "Error:${ErrorObject.mapFailureToErrorObject(failure: l).message}");
          }, (r) {
            Provider.of<BiometricProvider>(context, listen: false)
                .enroll(r.biometricToken, "biometric", r.userId);
            context.pop();
            // setState(() {
            //   _biometricStatus = true;
            // });
          });
        });
      });
    });
  }
}
