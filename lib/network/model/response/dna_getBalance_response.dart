// @dart=2.9
// To parse this JSON data, do
//
//     final dnaGetBalanceResponse = dnaGetBalanceResponseFromJson(jsonString);

import 'dart:convert';

DnaGetBalanceResponse dnaGetBalanceResponseFromJson(String str) =>
    DnaGetBalanceResponse.fromJson(json.decode(str));

String dnaGetBalanceResponseToJson(DnaGetBalanceResponse data) =>
    json.encode(data.toJson());

class DnaGetBalanceResponse {
  DnaGetBalanceResponse({
    this.jsonrpc,
    this.id,
    this.result,
    this.error,
  });

  String jsonrpc;
  int id;
  DnaGetBalanceResponseResult result;
  DnaGetBalanceResponseError error;

  factory DnaGetBalanceResponse.fromJson(Map<String, dynamic> json) =>
      DnaGetBalanceResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"] == null ? null : DnaGetBalanceResponseResult.fromJson(json["result"]),
        error: json["error"] == null ? null : DnaGetBalanceResponseError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
          "error": result.toJson(),
      };
}

class DnaGetBalanceResponseResult {
  DnaGetBalanceResponseResult({
    this.stake,
    this.balance,
    this.nonce,
  });

  String stake;
  String balance;
  int nonce;

  factory DnaGetBalanceResponseResult.fromJson(Map<String, dynamic> json) =>
      DnaGetBalanceResponseResult(
        stake: json["stake"],
        balance: json["balance"],
        nonce: json["nonce"],
      );

  Map<String, dynamic> toJson() => {
        "stake": stake,
        "balance": balance,
        "nonce": nonce,
      };
}


class DnaGetBalanceResponseError {
  DnaGetBalanceResponseError({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory DnaGetBalanceResponseError.fromJson(Map<String, dynamic> json) =>
      DnaGetBalanceResponseError(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}

