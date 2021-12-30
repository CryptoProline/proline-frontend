


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:web_ui/api/api_client.dart';
import 'package:web_ui/injector/injector.dart';
import 'package:web_ui/models/token_info.dart';
import 'package:web_ui/models/token_model.dart';
import 'package:web_ui/utils/shared_preferences_manager.dart';

var widget;

class PageTokenStateful extends StatefulWidget {
  final String? title;

  PageTokenStateful({Key? key, this.title}) : super(key: key);

  @override
  PageTokenState createState() => PageTokenState();
}

class PageTokenState extends State<PageTokenStateful> {
  final SharedPreferencesManager _sharedPreferencesManager = locator<SharedPreferencesManager>();
  @override
  void initState() {
    super.initState();
  }
  // ModalRoute;
  @override
  Widget build(BuildContext context) {
    print("building callback token page");
    Future.delayed(const Duration(milliseconds: 500), () async {
      final args = ModalRoute.of(this.context)?.settings.name;
      Uri uriData = Uri.parse(args!);
      String? code = uriData.queryParameters["code"];
      print("code=" + code!);

      Token token = await ApiClient.getOauth2Token('authorization_code', code, dotenv.env['REDIRECT_URI']);

      _sharedPreferencesManager.putString(
          SharedPreferencesManager.keyAccessToken, token.data.idToken);
      _sharedPreferencesManager.putString(
          SharedPreferencesManager.keyRefreshToken, token.data.refreshToken);

      // String tokenStr = jsonEncode(token.toJson());
      // print("tokenStr=" + tokenStr);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString("token", tokenStr);

      Navigator.of(context).pushNamed('/overview');
    });

    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
