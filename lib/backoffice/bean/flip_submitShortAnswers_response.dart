// To parse this JSON data, do
//
//     final flipSubmitShortAnswersResponse = flipSubmitShortAnswersResponseFromJson(jsonString);

import 'dart:convert';

FlipSubmitShortAnswersResponse flipSubmitShortAnswersResponseFromJson(
        String str) =>
    FlipSubmitShortAnswersResponse.fromJson(json.decode(str));

String flipSubmitShortAnswersResponseToJson(
        FlipSubmitShortAnswersResponse data) =>
    json.encode(data.toJson());

class FlipSubmitShortAnswersResponse {
  FlipSubmitShortAnswersResponse({
    this.jsonrpc,
    this.id,
    this.result,
    this.error,
  });

  String jsonrpc;
  int id;
  FlipSubmitShortAnswersResponseError error;
  FlipSubmitShortAnswersResponseResult result;

  factory FlipSubmitShortAnswersResponse.fromJson(Map<String, dynamic> json) =>
      FlipSubmitShortAnswersResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        error: json["error"] != null
            ? FlipSubmitShortAnswersResponseError.fromJson(json["error"])
            : null,
        result: json["result"] != null
            ? FlipSubmitShortAnswersResponseResult.fromJson(json["result"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "error": error.toJson(),
        "result": result.toJson(),
      };
}

class FlipSubmitShortAnswersResponseError {
  FlipSubmitShortAnswersResponseError({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory FlipSubmitShortAnswersResponseError.fromJson(
          Map<String, dynamic> json) =>
      FlipSubmitShortAnswersResponseError(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}

class FlipSubmitShortAnswersResponseResult {
  FlipSubmitShortAnswersResponseResult({
    this.txHash,
  });

  String txHash;

  factory FlipSubmitShortAnswersResponseResult.fromJson(
          Map<String, dynamic> json) =>
      FlipSubmitShortAnswersResponseResult(
        txHash: json["txHash"],
      );

  Map<String, dynamic> toJson() => {
        "txHash": txHash,
      };
}
