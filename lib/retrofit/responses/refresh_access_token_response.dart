import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_access_token_response.g.dart';

@JsonSerializable()
class RefreshAccessTokenResponse {
  @JsonKey(name: "access")
  String accessToken;

  RefreshAccessTokenResponse({required this.accessToken});

  factory RefreshAccessTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshAccessTokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshAccessTokenResponseToJson(this);
}
