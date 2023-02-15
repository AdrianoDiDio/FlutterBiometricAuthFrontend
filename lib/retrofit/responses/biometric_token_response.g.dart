// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiometricTokenResponse _$BiometricTokenResponseFromJson(
        Map<String, dynamic> json) =>
    BiometricTokenResponse(
      biometricToken: json['biometricToken'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$BiometricTokenResponseToJson(
        BiometricTokenResponse instance) =>
    <String, dynamic>{
      'biometricToken': instance.biometricToken,
      'userId': instance.userId,
    };
