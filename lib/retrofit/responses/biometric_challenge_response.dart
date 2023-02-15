import 'package:json_annotation/json_annotation.dart';

part 'biometric_challenge_response.g.dart';

@JsonSerializable()
class BiometricTokenChallengeResponse {
  String biometricChallenge;

  BiometricTokenChallengeResponse({required this.biometricChallenge});

  factory BiometricTokenChallengeResponse.fromJson(Map<String, dynamic> json) =>
      _$BiometricTokenChallengeResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$BiometricTokenChallengeResponseToJson(this);
}
