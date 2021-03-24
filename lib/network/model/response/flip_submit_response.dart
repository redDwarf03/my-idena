// @dart=2.9
// To parse this JSON data, do
//
//     final flipSubmitResponse = flipSubmitResponseFromJson(jsonString);

import 'dart:convert';

FlipSubmitResponse flipSubmitResponseFromJson(String str) =>
    FlipSubmitResponse.fromJson(json.decode(str));

String flipSubmitResponseToJson(FlipSubmitResponse data) =>
    json.encode(data.toJson());

class FlipSubmitResponse {
  FlipSubmitResponse({
    this.jsonrpc,
    this.id,
    this.error,
    this.result,
  });

  String jsonrpc;
  int id;
  FlipSubmitResponseError error;
  FlipSubmitResponseResult result;

  factory FlipSubmitResponse.fromJson(Map<String, dynamic> json) =>
      FlipSubmitResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        error: json["error"] != null
            ? FlipSubmitResponseError.fromJson(json["error"])
            : null,
        result: json["result"] != null
            ? FlipSubmitResponseResult.fromJson(json["result"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "error": error.toJson(),
        "result": result.toJson(),
      };
}

class FlipSubmitResponseError {
  FlipSubmitResponseError({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory FlipSubmitResponseError.fromJson(Map<String, dynamic> json) =>
      FlipSubmitResponseError(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}

class FlipSubmitResponseResult {
  FlipSubmitResponseResult({
    this.txHash,
    this.hash,
  });

  String txHash;
  String hash;

  factory FlipSubmitResponseResult.fromJson(Map<String, dynamic> json) =>
      FlipSubmitResponseResult(
        txHash: json["txHash"],
        hash: json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "txHash": txHash,
        "hash": hash,
      };
}
