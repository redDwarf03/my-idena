import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_idena/network/model/deepLinkParam.dart';
import 'package:my_idena/network/model/response/authenticate_response.dart';
import 'package:my_idena/network/model/response/nonce_end_point_response.dart';

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
      deepLinkParam.nonceEndpoint,
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
      else
      {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<DeepLinkParam> authenticate(DeepLinkParam deepLinkParam) async {
    final http.Response response = await http.post(
      deepLinkParam.authenticationEndpoint,
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
    else
    {
      return null;
    }
  }
}
