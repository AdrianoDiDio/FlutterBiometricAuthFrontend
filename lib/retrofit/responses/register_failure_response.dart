import 'package:json_annotation/json_annotation.dart';

part 'register_failure_response.g.dart';

@JsonSerializable()
class RegisterFailureResponse {
  List<String>? username;
  List<String>? email;
  List<String>? password;

  RegisterFailureResponse({this.username, this.email, this.password});

  factory RegisterFailureResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterFailureResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterFailureResponseToJson(this);
}
