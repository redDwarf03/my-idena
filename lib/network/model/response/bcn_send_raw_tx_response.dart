// @dart=2.9
// To parse this JSON data, do
//
//     final bcnSendRawTxResponse = bcnSendRawTxResponseFromJson(jsonString);

import 'dart:convert';

BcnSendRawTxResponse bcnSendRawTxResponseFromJson(String str) =>
    BcnSendRawTxResponse.fromJson(json.decode(str));

String bcnSendRawTxResponseToJson(BcnSendRawTxResponse data) =>
    json.encode(data.toJson());

class BcnSendRawTxResponse {
  BcnSendRawTxResponse({
    this.jsonrpc,
    this.id,
    this.error,
    this.result,
  });

  String jsonrpc;
  int id;
  BcnSendRawTxResponseError error;
  String result;

  factory BcnSendRawTxResponse.fromJson(Map<String, dynamic> json) =>
      BcnSendRawTxResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        error: json["error"] == null
            ? null
            : BcnSendRawTxResponseError.fromJson(json["error"]),
        result: json["result"] == null ? null : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "error": error.toJson(),
        "result": result,
      };
}

class BcnSendRawTxResponseError {
  BcnSendRawTxResponseError({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory BcnSendRawTxResponseError.fromJson(Map<String, dynamic> json) =>
      BcnSendRawTxResponseError(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
