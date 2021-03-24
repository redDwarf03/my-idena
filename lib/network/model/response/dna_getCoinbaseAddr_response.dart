// @dart=2.9
// To parse this JSON data, do
//
//     final dnaGetCoinbaseAddrResponse = dnaGetCoinbaseAddrResponseFromJson(jsonString);

import 'dart:convert';

DnaGetCoinbaseAddrResponse dnaGetCoinbaseAddrResponseFromJson(String str) =>
    DnaGetCoinbaseAddrResponse.fromJson(json.decode(str));

String dnaGetCoinbaseAddrResponseToJson(DnaGetCoinbaseAddrResponse data) =>
    json.encode(data.toJson());

class DnaGetCoinbaseAddrResponse {
  DnaGetCoinbaseAddrResponse({
    this.jsonrpc,
    this.id,
    this.result,
  });

  String jsonrpc;
  int id;
  String result;

  factory DnaGetCoinbaseAddrResponse.fromJson(Map<String, dynamic> json) =>
      DnaGetCoinbaseAddrResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result,
      };

  }
