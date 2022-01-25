



import 'package:jwt_decode/jwt_decode.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:web_ui/injector/injector.dart';
import 'package:web_ui/mqtt/consts.dart';
import 'package:web_ui/utils/shared_preferences_manager.dart';
// import 'package:sigv4/sigv4.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class AWSIotDevice {
  final String endpoint;
  final String clientId;
  final bool enableLogging;

  const AWSIotDevice({required this.endpoint, required this.clientId, this.enableLogging=false});

  Future<Map<String, String>> getCognitoCredentials() async {
    final userPool = CognitoUserPool(
      'us-east-1_AMmEjUEQO',
      'b5u050lva45encgtl4atvcc7s'
    );
    final SharedPreferencesManager _sharedPreferencesManager = locator<SharedPreferencesManager>();
    if (_sharedPreferencesManager.isKeyExists(SharedPreferencesManager.keyAccessToken) && _sharedPreferencesManager.isKeyExists(SharedPreferencesManager.keyRefreshToken) && _sharedPreferencesManager.isKeyExists(SharedPreferencesManager.keyAuthAccessToken)) {
      String? idToken = _sharedPreferencesManager.getString(SharedPreferencesManager.keyAccessToken);
      String? refreshToken = _sharedPreferencesManager.getString(SharedPreferencesManager.keyRefreshToken);
      String? accessToken = _sharedPreferencesManager.getString(SharedPreferencesManager.keyAuthAccessToken);
      final cognitoIdToken = CognitoIdToken(idToken);
      final cognitoAccessToken = CognitoAccessToken(accessToken);
      final cognitoRefreshToken = CognitoRefreshToken(refreshToken);


      final session = CognitoUserSession(cognitoIdToken, cognitoAccessToken, refreshToken: cognitoRefreshToken);

      final user = CognitoUser(null, userPool, signInUserSession: session);
      final credentials = CognitoCredentials('us-east-1:e3fc3cf9-d425-4140-b26e-55c761a8dad8', userPool);
      await credentials.getAwsCredentials(session.getIdToken().getJwtToken());
      return {
        'accessKey':credentials.accessKeyId!,
        'secretKey': credentials.secretAccessKey!,
        'sessionToken': credentials.sessionToken!,

      };
    }
    return {'status':"fail"};
  }
  

  Future<void> connect() async {
    print("INSIDE THE CONNECT FUN");
    final credentials = await getCognitoCredentials();
    print("accessKey: " + credentials['accessKey']!);
    print("secretKey: " + credentials['secretKey']!);
    print("sessionToken: " + credentials['sessionToken']!);
    var url = await getWebSocketUrl();
    var client = MqttBrowserClient(url, '');
    // var client = MqttBrowserClient(url, 'flutter');
    client.logging(on: enableLogging);
    client.websocketProtocols = ['mqtt', "x-amzn-mqtt-ca", "NA", 'wss'];
    client.port = 443;
    // client.port = 8883;
    client.setProtocolV311();
    client.connectionMessage =
        MqttConnectMessage().withClientIdentifier(clientId).keepAliveFor(300);
    client.keepAlivePeriod = 300;

    print("Before get Token param");
    
    
    var tokenParam = getTokenParam();
    print("after get Token param");
  // final connMessage = MqttConnectMessage()
  //     .withClientIdentifier('Mqtt_spl_id')
  //     .keepAliveFor(60) // Must agree with the keep alive set above or not set
  //     .withWillTopic('willtopic') // If you set this you must set a will message
  //     .withWillMessage('My Will message')
  //     .startClean() // Non persistent session for testing
  //     .authenticateAs(tokenParam["username"], tokenParam["token"])
  //     .withWillQos(MqttQos.atLeastOnce);
    // final connMessage = MqttConnectMessage()
    //   .withClientIdentifier('Mqtt_MyClientUniqueId')
    //   .withWillMessage('My Will message')
    //   .startClean() 
    //   .authenticateAs(tokenParam["username"], tokenParam["token"])
    //   .withWillQos(MqttQos.atLeastOnce);

    // client.connectionMessage = connMessage;

    try {
      print("ABOUT TO CONNNNECCCTTT");
      await client.connect();
      // await client.connect();
      print("AFTER CONNNNECCCTTT");
    } catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
      throw e;
    }

  }

  Future<String> getWebSocketUrl() async {
    var now = _generateDatetime();
    var region = getRegion();
    var credentials = await getCognitoCredentials();
    var creds = [
        credentials['accessKey'],
        _getDate(now),
        region,
        serviceName,
        awsS4Request,
      ];
    var queryParams = {
      'X-Amz-Algorithm': aws4HmacSha256,
      'X-Amz-Credential': creds.join('/'),
      'X-Amz-Date': now,
      'X-Amz-Expires': '86400',
      'X-Amz-SignedHeaders': 'host',
    };
    var canonicalQueryString = SigV4.buildCanonicalQueryString(queryParams);
    var request = SigV4.buildCanonicalRequest(
      'GET',
      urlPath,
      queryParams,
      {'host': endpoint},
      '',
    );
    var hashedCanonicalRequest = SigV4.hashCanonicalRequest(request);
    var stringToSign = SigV4.buildStringToSign(
      now,
      SigV4.buildCredentialScope(now, region, serviceName),
      hashedCanonicalRequest,
    );
    var signingKey = SigV4.calculateSigningKey(
      credentials['secretKey']!,
      now,
      region,
      serviceName,
    );
    var signature = SigV4.calculateSignature(signingKey, stringToSign);
    var securityTokenParam = Uri.encodeComponent(credentials['sessionToken']!);
    var finalParams = "$canonicalQueryString&X-Amz-Signature=$signature&X-Amz-Security-Token=$securityTokenParam";

    return '$scheme$endpoint$urlPath?$finalParams';
  }

  Map getTokenParam() {
    final SharedPreferencesManager _sharedPreferencesManager = locator<SharedPreferencesManager>();
    if (_sharedPreferencesManager.isKeyExists(SharedPreferencesManager.keyAccessToken)) {
      String? token = _sharedPreferencesManager.getString(SharedPreferencesManager.keyAccessToken);
      print("token:" + token!);
      Map<String, dynamic> idTokenPayload = Jwt.parseJwt(token);
      return {"username": idTokenPayload["email"], "token": token};
    } else {
      return {};
    }
  }

  String _generateDatetime() {
    return new DateTime.now()
        .toUtc()
        .toString()
        .replaceAll(new RegExp(r'\.\d*Z$'), 'Z')
        .replaceAll(new RegExp(r'[:-]|\.\d{3}'), '')
        .split(' ')
        .join('T');
  }

  String getRegion() {
    var endpointWithoutPort = endpoint.split(':')[0];
    var splits = endpointWithoutPort.split('.');
    var offset = splits.length == 7 ? 3 : 2;
    return splits[offset];
  }

  String _getDate(String dateTime) {
    return dateTime.substring(0, 8);
  }
}