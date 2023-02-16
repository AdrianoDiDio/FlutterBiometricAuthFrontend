import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:biometric_auth_frontend/failures/error_object.dart';
import 'package:biometric_auth_frontend/localizations_ext.dart';
import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/providers/auth_provider.dart';
import 'package:biometric_auth_frontend/providers/biometric_provider.dart';
import 'package:biometric_auth_frontend/retrofit/repositories/biometric_repository.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:biometric_auth_frontend/views/home/home_view.dart';
import 'package:biometric_auth_frontend/views/login/login_form.dart';
import 'package:biometric_auth_frontend/views/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pointycastle/asn1.dart';
import 'package:pointycastle/export.dart' hide State;
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
                        label: const Text("Login using biometrics"))),
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

  Uint8List rsaDecrypt(RSAPrivateKey myPrivate, Uint8List cipherText) {
    final decryptor = OAEPEncoding(RSAEngine())
      ..init(false,
          PrivateKeyParameter<RSAPrivateKey>(myPrivate)); // false=decrypt

    return _processInBlocks(decryptor, cipherText);
  }

  Uint8List _processInBlocks(AsymmetricBlockCipher engine, Uint8List input) {
    final numBlocks = input.length ~/ engine.inputBlockSize +
        ((input.length % engine.inputBlockSize != 0) ? 1 : 0);

    final output = Uint8List(numBlocks * engine.outputBlockSize);

    var inputOffset = 0;
    var outputOffset = 0;
    while (inputOffset < input.length) {
      final chunkSize = (inputOffset + engine.inputBlockSize <= input.length)
          ? engine.inputBlockSize
          : input.length - inputOffset;

      outputOffset += engine.processBlock(
          input, inputOffset, chunkSize, output, outputOffset);

      inputOffset += chunkSize;
    }

    return (output.length == outputOffset)
        ? output
        : output.sublist(0, outputOffset);
  }

  RSAPrivateKey _parsePrivateKeyFromPem(pemString) {
    Uint8List privateKeyDER = base64.decode(pemString);
    var asn1Parser = ASN1Parser(privateKeyDER);
    var topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;
    // var version = topLevelSeq.elements?[0];
    // var algorithm = topLevelSeq.elements?[1];
    var privateKey = topLevelSeq.elements![2];

    asn1Parser = ASN1Parser(privateKey.valueBytes);
    var pkSeq = asn1Parser.nextObject() as ASN1Sequence;

    // version = pkSeq.elements![0];
    var modulus = pkSeq.elements![1] as ASN1Integer;
    var privateExponent = pkSeq.elements![3] as ASN1Integer;
    var p = pkSeq.elements![4] as ASN1Integer;
    var q = pkSeq.elements![5] as ASN1Integer;
    var modulusInteger = modulus.integer;
    RSAPrivateKey rsaPrivateKey = RSAPrivateKey(
        modulusInteger!, privateExponent.integer!, p.integer!, q.integer!);

    return rsaPrivateKey;
  }

  void _attemptBiometricLogin(BuildContext context) async {
    StorageUtils storageUtils = serviceLocator.get<StorageUtils>();
    String? biometricToken =
        await storageUtils.read(StorageKeys.biometricsToken);
    String? biometricUserId =
        await storageUtils.read(StorageKeys.biometricsUserId);
    String? biometricPrivateKey =
        await storageUtils.read(StorageKeys.biometricsPrivateKey);

    if (biometricToken != null &&
        biometricUserId != null &&
        biometricPrivateKey != null) {
      Uint8List encryptedBiometricToken = base64Decode(biometricToken);
      // final decryptor = OAEPEncoding(RSAEngine())
      //   ..init(
      //       false,
      //       PrivateKeyParameter<RSAPrivateKey>(
      //           )); // false=decrypt

      var cipher = OAEPEncoding.withSHA256(RSAEngine())
        ..init(
            false,
            PrivateKeyParameter<RSAPrivateKey>(
                _parsePrivateKeyFromPem(biometricPrivateKey)));
      cipher.mgf1Hash = SHA1Digest();
      var decrypted = cipher.process(encryptedBiometricToken);
      var base64DecodedToken = base64.encode(decrypted);
      logger.d("Decrypted token $base64DecodedToken");
      BiometricRepositoryImplementation biometricRepositoryImplementation =
          BiometricRepositoryImplementation();
      var response = await biometricRepositoryImplementation.biometricLogin(
          int.parse(biometricUserId), base64DecodedToken);
      response.fold(
          (l) => {
                logger
                    .d(ErrorObject.mapFailureToErrorObject(failure: l).message)
              }, (r) {
        logger.d("Login successful...${r.accessToken}");
        Provider.of<AuthProvider>(context, listen: false)
            .login(r.accessToken, r.refreshToken);
      });
    }
  }
}
