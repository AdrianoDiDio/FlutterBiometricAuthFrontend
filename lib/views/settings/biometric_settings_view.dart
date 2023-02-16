import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:biometric_auth_frontend/failures/error_object.dart';
import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:biometric_auth_frontend/locator.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:biometric_auth_frontend/providers/biometric_provider.dart';
import 'package:biometric_auth_frontend/retrofit/repositories/biometric_repository.dart';
import 'package:biometric_auth_frontend/retrofit/responses/biometric_challenge_response.dart';
import 'package:biometric_auth_frontend/size_config.dart';
import 'package:biometric_auth_frontend/utils/storage_keys.dart';
import 'package:biometric_auth_frontend/utils/storage_utils.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pointycastle/asn1.dart';
import 'package:pointycastle/export.dart' hide State, Padding;
import 'package:provider/provider.dart';

AsymmetricKeyPair<PublicKey, PrivateKey> generateRSAKeyPair(
    SecureRandom secureRandom) {
  var rsapars = RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 5);
  var params = ParametersWithRandom(rsapars, secureRandom);
  var keyGenerator = RSAKeyGenerator();
  keyGenerator.init(params);
  return keyGenerator.generateKeyPair();
}

class BiometricSettingsView extends StatefulWidget {
  static String routeName = "biometrics";
  static String routePath = "biometrics";

  const BiometricSettingsView({super.key});

  @override
  State<StatefulWidget> createState() {
    return BiometricSettingsViewState();
  }
}

class BiometricSettingsViewState extends State<BiometricSettingsView> {
  late bool _biometricStatus = false;

  void _init() async {
    String? biometricEnrolled = await serviceLocator
        .get<StorageUtils>()
        .read(StorageKeys.biometricsToken);
    setState(() {
      _biometricStatus = biometricEnrolled != null ? true : false;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

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
                        Text("Enable biometric authentication",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 3)),
                        Switch(
                          value: _biometricStatus,
                          onChanged: (value) {
                            if (!value) {
                              logger.d("Removing biometric data...");
                              Provider.of<BiometricProvider>(context,
                                      listen: false)
                                  .cancel();
                              setState(() {
                                _biometricStatus = false;
                              });
                            } else {
                              logger.d("Starting on-board process");
                              _enrollBiometricToken();
                            }
                          },
                        )
                      ])
                ]))));
  }

  SecureRandom getSecureRandom() {
    var secureRandom = FortunaRandom();
    var random = Random.secure();
    List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }

  String encodePublicKeyToPemPKCS1(RSAPublicKey publicKey) {
    var algorithmSeq = ASN1Sequence();
    var paramsAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0]));
    algorithmSeq.add(ASN1ObjectIdentifier.fromName('rsaEncryption'));
    algorithmSeq.add(paramsAsn1Obj);

    var publicKeySeq = ASN1Sequence();
    publicKeySeq.add(ASN1Integer(publicKey.modulus));
    publicKeySeq.add(ASN1Integer(publicKey.exponent));
    var publicKeySeqBitString =
        ASN1BitString(stringValues: Uint8List.fromList(publicKeySeq.encode()));

    var topLevelSeq = ASN1Sequence();
    topLevelSeq.add(algorithmSeq);
    topLevelSeq.add(publicKeySeqBitString);
    var dataBase64 = base64.encode(topLevelSeq.encode());
    return dataBase64.toString();
  }

  String encodePrivateKeyToPemPKCS1(RSAPrivateKey privateKey) {
    var version = ASN1Integer(BigInt.from(0));

    var algorithmSeq = ASN1Sequence();
    var algorithmAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList(
        [0x6, 0x9, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0xd, 0x1, 0x1, 0x1]));
    var paramsAsn1Obj = ASN1Object.fromBytes(Uint8List.fromList([0x5, 0x0]));
    algorithmSeq.add(algorithmAsn1Obj);
    algorithmSeq.add(paramsAsn1Obj);

    var privateKeySeq = ASN1Sequence();
    var modulus = ASN1Integer(privateKey.n);
    var publicExponent = ASN1Integer(BigInt.parse('65537'));
    var privateExponent = ASN1Integer(privateKey.privateExponent);
    var p = ASN1Integer(privateKey.p);
    var q = ASN1Integer(privateKey.q);
    var dP = privateKey.privateExponent! % (privateKey.p! - BigInt.from(1));
    var exp1 = ASN1Integer(dP);
    var dQ = privateKey.privateExponent! % (privateKey.q! - BigInt.from(1));
    var exp2 = ASN1Integer(dQ);
    var iQ = privateKey.q!.modInverse(privateKey.p!);
    var co = ASN1Integer(iQ);

    privateKeySeq.add(version);
    privateKeySeq.add(modulus);
    privateKeySeq.add(publicExponent);
    privateKeySeq.add(privateExponent);
    privateKeySeq.add(p);
    privateKeySeq.add(q);
    privateKeySeq.add(exp1);
    privateKeySeq.add(exp2);
    privateKeySeq.add(co);
    var publicKeySeqOctetString =
        ASN1OctetString(octets: Uint8List.fromList(privateKeySeq.encode()));

    var topLevelSeq = ASN1Sequence();
    topLevelSeq.add(version);
    topLevelSeq.add(algorithmSeq);
    topLevelSeq.add(publicKeySeqOctetString);
    var dataBase64 = base64.encode(topLevelSeq.encode());
    return dataBase64;
  }

  Future<AsymmetricKeyPair<PublicKey, PrivateKey>> getRSAKeyPair(
      SecureRandom secureRandom) async {
    return await compute(generateRSAKeyPair, secureRandom);
  }

  void _enrollBiometricToken() async {
    BiometricRepositoryImplementation biometricRepositoryImplementation =
        BiometricRepositoryImplementation();

    Either<Failure, BiometricTokenChallengeResponse>
        biometricChallengeResponse =
        await biometricRepositoryImplementation.getBiometricChallenge();
    biometricChallengeResponse.fold((l) {
      ErrorObject errorObject = ErrorObject.mapFailureToErrorObject(failure: l);
      logger.d("Couldn't generate a challenge...${errorObject.message}");
      setState(() {
        _biometricStatus = false;
      });
    }, (r) async {
      String decodedChallenge = utf8.decode(base64Decode(r.biometricChallenge));
      logger.d(
          "Got challenge ${r.biometricChallenge} decoded to $decodedChallenge");
      logger.d("Next step!");
      Random random = Random();
      var nonce = random.nextInt(4294967296);
      String decodedChallengeWithNonce = decodedChallenge + nonce.toString();
      //Generate RSA key-pair
      getRSAKeyPair(getSecureRandom()).then((value) async {
        logger.d(
            "Public Key:${encodePublicKeyToPemPKCS1(value.publicKey as RSAPublicKey)}");
        logger.d("Nonce:${nonce}");

        final signer = RSASigner(SHA256Digest(), '0609608648016503040201');
        signer.init(true, PrivateKeyParameter<RSAPrivateKey>(value.privateKey));
        final sign = signer.generateSignature(
            Uint8List.fromList(decodedChallengeWithNonce.codeUnits));
        final sentSign = base64Encode(sign.bytes);
        logger.d("sign $sentSign");
        var biometricTokenResponse =
            await biometricRepositoryImplementation.getBiometricToken(
                sentSign,
                nonce,
                encodePublicKeyToPemPKCS1(value.publicKey as RSAPublicKey));
        biometricTokenResponse.fold((l) {
          setState(() {
            _biometricStatus = false;
          });
          logger.d(
              "Error:${ErrorObject.mapFailureToErrorObject(failure: l).message}");
        }, (r) {
          Provider.of<BiometricProvider>(context, listen: false).enroll(
              r.biometricToken,
              encodePrivateKeyToPemPKCS1(value.privateKey as RSAPrivateKey),
              r.userId);
          setState(() {
            _biometricStatus = true;
          });
        });
      });
    });
  }
}
