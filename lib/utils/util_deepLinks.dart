import 'dart:convert';

import 'package:my_idena/backoffice/bean/authenticate_response.dart';
import 'package:my_idena/backoffice/bean/nonce_end_point_response.dart';
import 'package:my_idena/beans/deepLinkParam.dart';
import 'package:http/http.dart' as http;

class UtilDeepLinks {
  bool isValidUrl(String url) {
    bool _validURL = Uri.parse(url).isAbsolute;
    return _validURL;
  }

  String getHostname(String url) {
    return Uri.parse(url).host;
  }

  Future<DeepLinkParam> getNonce(DeepLinkParam deepLinkParam) async {
    final http.Response response = await http.post(
      deepLinkParam.nonce_endpoint,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': deepLinkParam.token,
        'address': deepLinkParam.address,
      }),
    );
    if (response.statusCode == 200) {
      NonceEndpointResponse nonceEndpointResponse =
          NonceEndpointResponse.fromJson(json.decode(response.body));
      if (nonceEndpointResponse.success && nonceEndpointResponse.data.nonce.startsWith('signin-')) {
        deepLinkParam.nonce = nonceEndpointResponse.data.nonce;
        return deepLinkParam;
      }
    } else {
      return null;
    }
  }

  Future<DeepLinkParam> authenticate(DeepLinkParam deepLinkParam) async {
    final http.Response response = await http.post(
      deepLinkParam.authentication_endpoint,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': deepLinkParam.token,
        'signature': deepLinkParam.signature,
      }),
    );
    if (response.statusCode == 200) {
      AuthenticateResponse authenticateResponse =
          AuthenticateResponse.fromJson(json.decode(response.body));
      deepLinkParam.authenticated = authenticateResponse.data.authenticated;
      return deepLinkParam;
    } 
  }
}
