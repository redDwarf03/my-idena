// To parse this JSON data, do
//
//     final getFlipRawResponse = getFlipRawResponseFromJson(jsonString);

import 'dart:convert';

GetFlipRawResponse getFlipRawResponseFromJson(String str) =>
    GetFlipRawResponse.fromJson(json.decode(str));

String getFlipRawResponseToJson(GetFlipRawResponse data) =>
    json.encode(data.toJson());

class GetFlipRawResponse {
  GetFlipRawResponse({
    this.jsonrpc,
    this.id,
    this.result,
  });

  String jsonrpc;
  int id;
  GetFlipRawResponseResult result;

  factory GetFlipRawResponse.fromJson(Map<String, dynamic> json) =>
      GetFlipRawResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: GetFlipRawResponseResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
      };
}

class GetFlipRawResponseResult {
  GetFlipRawResponseResult({
    this.publicHex,
    this.privateHex,
  });

  String publicHex;
  String privateHex;

  factory GetFlipRawResponseResult.fromJson(Map<String, dynamic> json) =>
      GetFlipRawResponseResult(
        publicHex: json["publicHex"],
        privateHex: json["privateHex"],
      );

  Map<String, dynamic> toJson() => {
        "publicHex": publicHex,
        "privateHex": privateHex,
      };
}
