// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
    Token({
        required this.statusCode,
        required this.statusText,
        required this.data,
    });

    int statusCode;
    String statusText;
    Data data;

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        statusCode: json["status_code"],
        statusText: json["status_text"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_text": statusText,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.idToken,
        required this.accessToken,
        required this.refreshToken,
        required this.expiresIn,
        required this.tokenType,
    });

    String idToken;
    String accessToken;
    String refreshToken;
    int expiresIn;
    String tokenType;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idToken: json["id_token"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        expiresIn: json["expires_in"],
        tokenType: json["token_type"],
    );

    Map<String, dynamic> toJson() => {
        "id_token": idToken,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "expires_in": expiresIn,
        "token_type": tokenType,
    };
}
