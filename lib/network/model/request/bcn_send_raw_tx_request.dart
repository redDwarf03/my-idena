// @dart=2.9
// To parse this JSON data, do
//
//     final bcnSendRawTxRequest = bcnSendRawTxRequestFromJson(jsonString);

import 'dart:convert';

BcnSendRawTxRequest bcnSendRawTxRequestFromJson(String str) =>
    BcnSendRawTxRequest.fromJson(json.decode(str));

String bcnSendRawTxRequestToJson(BcnSendRawTxRequest data) =>
    json.encode(data.toJson());

class BcnSendRawTxRequest {
  BcnSendRawTxRequest({
    this.method,
    this.params,
    this.id,
    this.key,
  });

  String method;
  List<String> params;
  int id;
  String key;

  static const METHOD_NAME = "bcn_sendRawTx";

  factory BcnSendRawTxRequest.fromJson(Map<String, dynamic> json) =>
      BcnSendRawTxRequest(
        method: json["method"],
        params: List<String>.from(json["params"].map((x) => x)),
        id: json["id"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "method": method,
        "params": List<dynamic>.from(params.map((x) => x)),
        "id": id,
        "key": key,
      };
}
