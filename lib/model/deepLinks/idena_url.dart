import 'dart:convert';
import 'dart:typed_data';
import 'package:my_idena/model/deepLinks/deepLinkParamSend.dart';
import 'package:my_idena/model/deepLinks/deepLinkParamSignin.dart';
import 'package:http/http.dart' as http;
import 'package:my_idena/network/model/response/authenticate_response.dart';
import 'package:my_idena/network/model/response/nonce_end_point_response.dart';
import 'package:web3dart/crypto.dart' as crypto;


class IdenaUrl {
  DeepLinkParamSignin deepLinkParamSignin;
  DeepLinkParamSend deepLinkParamSend;

  IdenaUrl();

  IdenaUrl getInfo(String link) {
    this.deepLinkParamSignin = null;
    this.deepLinkParamSend = null;
    var list;
    Uri _latestUri;
    if (link != null) _latestUri = Uri.parse(link);

    if (_latestUri != null && _latestUri.host == DeepLinkParamSend.HOST) {
      list = _latestUri?.queryParametersAll?.entries?.toList();
      if (list != null) {
        deepLinkParamSend = new DeepLinkParamSend();
        for (var i = 0; i < list.length; i++) {
          switch (list[i].key) {
            case "address":
              {
                deepLinkParamSend.address = list[i].value[0];
              }
              break;
            case "amount":
              {
                deepLinkParamSend.amount = list[i].value[0];
              }
              break;
            case "comment":
              {
                deepLinkParamSend.comment = list[i].value[0];
              }
              break;
          }
        }
      }
      //print("address: " + deepLinkParamSend.address);
      //print("amount: " + deepLinkParamSend.amount);
      //print("comment: " + deepLinkParamSend.comment);
      this.deepLinkParamSend = deepLinkParamSend;

      return this;
    } else if (_latestUri != null &&
        _latestUri.host == DeepLinkParamSignin.HOST) {
      list = _latestUri?.queryParametersAll?.entries?.toList();
      if (list != null) {
        deepLinkParamSignin = new DeepLinkParamSignin();
        for (var i = 0; i < list.length; i++) {
          switch (list[i].key) {
            case "nonce_endpoint":
              {
                deepLinkParamSignin.nonceEndpoint = list[i].value[0];
              }
              break;
            case "token":
              {
                deepLinkParamSignin.token = list[i].value[0];
              }
              break;
            case "callback_url":
              {
                deepLinkParamSignin.callbackUrl = list[i].value[0];
              }
              break;
            case "authentication_endpoint":
              {
                deepLinkParamSignin.authenticationEndpoint = list[i].value[0];
              }
              break;
          }
        }
        //print("nonce_endpoint: " + deepLinkParamSignin.nonceEndpoint);
        //print("token: " + deepLinkParamSignin.token);
        //print("callback_url: " + deepLinkParamSignin.callbackUrl);
        //print("authentication_endpoint: " +
        //    deepLinkParamSignin.authenticationEndpoint);
        this.deepLinkParamSignin = deepLinkParamSignin;

        return this;
      }
    }

    return null;
  }

  Future<DeepLinkParamSignin> getNonce(
      DeepLinkParamSignin deepLinkParam) async {
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
      if (nonceEndpointResponse.success &&
          nonceEndpointResponse.data.nonce.startsWith('signin-')) {
        deepLinkParam.nonce = nonceEndpointResponse.data.nonce;
        return deepLinkParam;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  String getHostname(String url) {
    return Uri.parse(url).host;
  }

  Future<DeepLinkParamSignin> authenticate(
      DeepLinkParamSignin deepLinkParam) async {
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
    } else {
      return null;
    }
  }

  Uint8List getNonceInternal(String nonceEndpoint, String privateKey) {
    var nonceHash = crypto.keccak256(
        crypto.keccak256(Uint8List.fromList(utf8.encode(nonceEndpoint))));
    print("nonceHash : " + nonceHash.toString());

    crypto.MsgSignature msgSignature =
        crypto.sign(nonceHash, crypto.hexToBytes(privateKey));

    final header = msgSignature.v & 0xFF;
    var recId = header - 27;
    var signature = Uint8List.fromList(([
      ...padUint8ListTo32(crypto.intToBytes(msgSignature.r)),
      ...padUint8ListTo32(crypto.intToBytes(msgSignature.s)),
      recId
    ]));

    print("signature : " + signature.toString());

    return signature;
  }

  Uint8List padUint8ListTo32(Uint8List data) {
    assert(data.length <= 32);
    if (data.length == 32) return data;

    // todo there must be a faster way to do this?
    return Uint8List(32)..setRange(32 - data.length, 32, data);
  }
}
