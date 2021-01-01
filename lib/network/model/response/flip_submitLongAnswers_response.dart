// To parse this JSON data, do
//
//     final flipSubmitLongAnswersResponse = flipSubmitLongAnswersResponseFromJson(jsonString);

import 'dart:convert';

FlipSubmitLongAnswersResponse flipSubmitLongAnswersResponseFromJson(
        String str) =>
    FlipSubmitLongAnswersResponse.fromJson(json.decode(str));

String flipSubmitLongAnswersResponseToJson(
        FlipSubmitLongAnswersResponse data) =>
    json.encode(data.toJson());

class FlipSubmitLongAnswersResponse {
  FlipSubmitLongAnswersResponse({
    this.jsonrpc,
    this.id,
    this.result,
    this.error,
  });

  String jsonrpc;
  int id;
  FlipSubmitLongAnswersResponseError error;
  FlipSubmitLongAnswersResponseResult result;

  factory FlipSubmitLongAnswersResponse.fromJson(Map<String, dynamic> json) =>
      FlipSubmitLongAnswersResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        error: json["error"] != null
            ? FlipSubmitLongAnswersResponseError.fromJson(json["error"])
            : null,
        result: json["result"] != null
            ? FlipSubmitLongAnswersResponseResult.fromJson(json["result"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "error": error.toJson(),
        "result": result.toJson(),
      };
}

class FlipSubmitLongAnswersResponseError {
  FlipSubmitLongAnswersResponseError({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory FlipSubmitLongAnswersResponseError.fromJson(
          Map<String, dynamic> json) =>
      FlipSubmitLongAnswersResponseError(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}

class FlipSubmitLongAnswersResponseResult {
  FlipSubmitLongAnswersResponseResult({
    this.txHash,
  });

  String txHash;

  factory FlipSubmitLongAnswersResponseResult.fromJson(
          Map<String, dynamic> json) =>
      FlipSubmitLongAnswersResponseResult(
        txHash: json["txHash"],
      );

  Map<String, dynamic> toJson() => {
        "txHash": txHash,
      };
}
