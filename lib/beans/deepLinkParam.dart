import 'dart:convert';

class DeepLinkParam {
  String nonce_endpoint;
  String token;
  String callback_url;
  String authentication_endpoint;
  String favicon_url;
  String nonce;
  String address;
  String signature;
  bool authenticated;
  DeepLinkParam();
}
