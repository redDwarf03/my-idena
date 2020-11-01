// To parse this JSON data, do
//
//     final bcnSyncingResponse = bcnSyncingResponseFromJson(jsonString);

import 'dart:convert';

BcnSyncingResponse bcnSyncingResponseFromJson(String str) =>
    BcnSyncingResponse.fromJson(json.decode(str));

String bcnSyncingResponseToJson(BcnSyncingResponse data) =>
    json.encode(data.toJson());

class BcnSyncingResponse {
  BcnSyncingResponse({
    this.jsonrpc,
    this.id,
    this.result,
  });

  String jsonrpc;
  int id;
  BcnSyncingResponseResult result;

  factory BcnSyncingResponse.fromJson(Map<String, dynamic> json) =>
      BcnSyncingResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: BcnSyncingResponseResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
      };
}

class BcnSyncingResponseResult {
  BcnSyncingResponseResult({
    this.syncing,
    this.currentBlock,
    this.highestBlock,
    this.wrongTime,
    this.genesisBlock,
  });

  bool syncing;
  int currentBlock;
  int highestBlock;
  bool wrongTime;
  int genesisBlock;

  factory BcnSyncingResponseResult.fromJson(Map<String, dynamic> json) =>
      BcnSyncingResponseResult(
        syncing: json["syncing"],
        currentBlock: json["currentBlock"],
        highestBlock: json["highestBlock"],
        wrongTime: json["wrongTime"],
        genesisBlock: json["genesisBlock"],
      );

  Map<String, dynamic> toJson() => {
        "syncing": syncing,
        "currentBlock": currentBlock,
        "highestBlock": highestBlock,
        "wrongTime": wrongTime,
        "genesisBlock": genesisBlock,
      };
}
