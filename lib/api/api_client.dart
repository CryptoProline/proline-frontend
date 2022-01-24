import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:web_ui/injector/injector.dart';
import 'package:web_ui/models/pools_model.dart';
import 'package:web_ui/models/token_info.dart';
import 'package:web_ui/models/token_model.dart';
import 'package:web_ui/utils/shared_preferences_manager.dart';

class ApiClient {
  static Future<Token> getOauth2Token(grantType, code, redirectUri) async {
    final queryParameters = <String, dynamic>{
      r'grant_type': grantType,
      r'code': code,
      r'redirect_uri': redirectUri
    };
    var _response = await http.post(getUri('${dotenv.env['API_NAME']}',
        '${dotenv.env['API_VERSION']}/oauth2/token', queryParameters));
    print("Response" + _response.body);
    var _token = tokenFromJson(_response.body);
    return _token;
  }

  static Future<Pools> getOpenPools() async {
    Map<String, dynamic> qParams = {
      'status': 'OPEN',
    };
    var _response = await http.get(getUri('${dotenv.env['API_NAME']}',
        '${dotenv.env['API_VERSION']}/pools', qParams));
    var _pools = PoolsFromJson(_response.body);
    return _pools;
  }

  static Future<String> getCoinbaseUrl(Map data) async {
    var body = json.encode(data);
    final SharedPreferencesManager _sharedPreferencesManager = locator<SharedPreferencesManager>();
    if (_sharedPreferencesManager.isKeyExists(SharedPreferencesManager.keyAccessToken)) {
      String? token = _sharedPreferencesManager.getString(SharedPreferencesManager.keyAccessToken);
      print(token);
      var _qParams = {'Authorization': 'Bearer ' + token!};
      var _response = await http.post(
          getUri('${dotenv.env['API_NAME']}',
              '${dotenv.env['API_VERSION']}/payments/coinbase'),
          body: body,
          headers: _qParams);
      var decodedResp = json.decode(_response.body);
      return decodedResp["data"]["transaction_url"];
    }
    return "";
  }

  static Uri getUri(String authority, String unencodedPath,
      [Map<String, dynamic>? queryParameters]) {
    if (authority.contains("localhost"))
      return Uri.http(authority, unencodedPath, queryParameters);
    else
      return Uri.https(authority, unencodedPath, queryParameters);
  }
}
