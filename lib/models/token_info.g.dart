// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenInfo _$TokenInfoFromJson(Map<String, dynamic> json) {
  return TokenInfo(
    data: TokenData.fromJson(json['data'] as Map<String, dynamic>),
    status_code: json['status_code'] as int,
    status_text: json['status_text'] as String,
  );
}

Map<String, dynamic> _$TokenInfoToJson(TokenInfo instance) => <String, dynamic>{
      'data': instance.data,
      'status_code': instance.status_code,
      'status_text': instance.status_text,
    };

TokenData _$TokenDataFromJson(Map<String, dynamic> json) {
  return TokenData(
    id_token: json['id_token'] as String,
    access_token: json['access_token'] as String,
    refresh_token: json['refresh_token'] as String,
    expires_in: json['expires_in'] as int,
    token_type: json['token_type'] as String,
  );
}

Map<String, dynamic> _$TokenDataToJson(TokenData instance) => <String, dynamic>{
      'id_token': instance.id_token,
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
      'expires_in': instance.expires_in,
      'token_type': instance.token_type,
    };
