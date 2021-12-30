import 'package:json_annotation/json_annotation.dart';

part 'token_info.g.dart';

@JsonSerializable()
class TokenInfo {
  TokenData data;
  int status_code; 
  String status_text;

  TokenInfo({required this.data, required this.status_code, required this.status_text});

  factory TokenInfo.fromJson(Map<String, dynamic> json) =>
      _$TokenInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TokenInfoToJson(this);
}

@JsonSerializable()
class TokenData {
  String id_token;
  String access_token;
  String refresh_token;
  int expires_in;
  String token_type;

  TokenData(
      {required this.id_token,
      required this.access_token,
      required this.refresh_token,
      required this.expires_in,
      required this.token_type});

  factory TokenData.fromJson(Map<String, dynamic> json) =>
      _$TokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$TokenDataToJson(this);
}
