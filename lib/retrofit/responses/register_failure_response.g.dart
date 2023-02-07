// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_failure_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterFailureResponse _$RegisterFailureResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterFailureResponse(
      username: (json['username'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      email:
          (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
      password: (json['password'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RegisterFailureResponseToJson(
        RegisterFailureResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
    };
