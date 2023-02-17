import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:biometric_auth_frontend/failures/failure.dart';
import 'package:biometric_auth_frontend/logger.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pointycastle/asn1.dart';
import 'package:pointycastle/export.dart';

AsymmetricKeyPair<PublicKey, PrivateKey> getRSAKeyPair(
    SecureRandom secureRandom) {
  var rsapars = RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 5);
  var params = ParametersWithRandom(rsapars, secureRandom);
  var keyGenerator = RSAKeyGenerator();
  keyGenerator.init(params);
  return keyGenerator.generateKeyPair();
}

class BiometricUtils {
  late bool _biometricSupported;

  bool get biometricSupported => _biometricSupported;

  BiometricUtils() {
    _init();
  }

  void _init() async {
    logger.d("BiometricUtils initialization...");
    _biometricSupported = await isBiometricSupported();
    logger.d("Device is supported $_biometricSupported");
  }

  Future<bool> isBiometricSupported() async {
    LocalAuthentication localAuthentication = LocalAuthentication();
    return await localAuthentication.isDeviceSupported();
  }

  static String encodePublicKeyToPemPKCS1(RSAPublicKey publicKey) {
    ASN1Sequence topLevel = ASN1Sequence();

    topLevel.add(ASN1Integer(publicKey.modulus!));
    topLevel.add(ASN1Integer(publicKey.exponent!));

    return base64.encode(topLevel.encode());
  }

  static String encodePrivateKeyToPemPKCS1(RSAPrivateKey privateKey) {
    var version = ASN1Integer(BigInt.from(0));
    var privateKeySeq = ASN1Sequence();
    var modulus = ASN1Integer(privateKey.n);
    var publicExponent = ASN1Integer(privateKey.publicExponent);
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
    var dataBase64 = base64.encode(privateKeySeq.encode());
    return dataBase64;
  }

  /// Create an RSAPrivateKey from a PEM encoded string.
  /// NOTE that the PEM format we use only contains the Base64 data without
  /// headers.
  static RSAPrivateKey parsePrivateKeyFromPemPKCS1(String pemString) {
    Uint8List privateKeyDER = base64.decode(pemString);
    ASN1Parser asn1Parser = ASN1Parser(privateKeyDER);
    ASN1Sequence topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

    ASN1Integer modulus = topLevelSeq.elements![1] as ASN1Integer;
    ASN1Integer privateExponent = topLevelSeq.elements![3] as ASN1Integer;
    ASN1Integer p = topLevelSeq.elements![4] as ASN1Integer;
    ASN1Integer q = topLevelSeq.elements![5] as ASN1Integer;

    RSAPrivateKey rsaPrivateKey = RSAPrivateKey(
        modulus.integer!, privateExponent.integer!, p.integer!, q.integer!);

    return rsaPrivateKey;
  }

  /// Decrypt a Base64 encoded string using the provided private key encoded
  /// as a PEM string.
  /// NOTE that the PEM format we use only contains the Base64 data without
  /// headers.
  static Either<Failure, Uint8List> decryptRSA(
      String privateKeyAsPEM, String encryptedBase64Secret) {
    var cipher = OAEPEncoding.withSHA256(RSAEngine())
      ..init(
          false,
          PrivateKeyParameter<RSAPrivateKey>(
              parsePrivateKeyFromPemPKCS1(privateKeyAsPEM)));
    cipher.mgf1Hash = SHA1Digest();
    try {
      return Right(cipher.process(base64.decode(encryptedBase64Secret)));
    } catch (e) {
      return const Left(DecryptRSAFailure());
    }
  }

  static RSASignature signRSA(RSAPrivateKey privateKey, Uint8List message) {
    final signer = RSASigner(SHA256Digest(), '0609608648016503040201');
    signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
    return signer.generateSignature(message);
  }

  static SecureRandom getSecureRandom() {
    var secureRandom = FortunaRandom();
    var random = Random.secure();
    List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }

  static Future<AsymmetricKeyPair<PublicKey, PrivateKey>>
      generateRSAKeyPair() async {
    return await compute(getRSAKeyPair, getSecureRandom());
  }
}
