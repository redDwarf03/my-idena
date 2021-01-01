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
  });

  String jsonrpc;
  int id;
  DnaGetBalanceResponseResult result;

  factory DnaGetBalanceResponse.fromJson(Map<String, dynamic> json) =>
      DnaGetBalanceResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: DnaGetBalanceResponseResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
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
