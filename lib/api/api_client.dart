import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_ui/models/pools_model.dart';
import 'package:web_ui/models/token_info.dart';
import 'package:web_ui/models/token_model.dart';


class ApiClient {
  static Future<Token> getOauth2Token(grantType, code, redirectUri) async {
      final queryParameters = <String, dynamic>{
        r'grant_type': grantType,
        r'code': code,
        r'redirect_uri': redirectUri
      };
      var _response = await http.post(Uri.http('localhost:3000', 'prod/oauth2/token', queryParameters));
      print("Response" + _response.toString());
      var _token = tokenFromJson(_response.body);
      return _token;
  }

  static Future<Pools> getOpenPools() async {
    Map<String, dynamic> qParams = {
      'status':'OPEN',
    };
    var _response = await http.get(Uri.https('api-dev.cryptoproline.com', 'v1/pools', qParams));
    var _pools = PoolsFromJson(_response.body);
    return _pools;
  }



  
}