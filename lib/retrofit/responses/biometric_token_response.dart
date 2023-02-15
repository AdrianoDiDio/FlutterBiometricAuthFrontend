import 'package:json_annotation/json_annotation.dart';

part 'biometric_token_response.g.dart';

@JsonSerializable()
class BiometricTokenResponse {
  String biometricToken;
  String userId;

  BiometricTokenResponse({required this.biometricToken, required this.userId});

  factory BiometricTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$BiometricTokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BiometricTokenResponseToJson(this);
}
