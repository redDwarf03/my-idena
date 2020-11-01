// To parse this JSON data, do
//
//     final flipLongHashesResponse = flipLongHashesResponseFromJson(jsonString);

import 'dart:convert';

FlipLongHashesResponse flipLongHashesResponseFromJson(String str) =>
    FlipLongHashesResponse.fromJson(json.decode(str));

String flipLongHashesResponseToJson(FlipLongHashesResponse data) =>
    json.encode(data.toJson());

class FlipLongHashesResponse {
  FlipLongHashesResponse({
    this.jsonrpc,
    this.id,
    this.result,
  });

  String jsonrpc;
  int id;
  List<FlipLongHashesResponseResult> result;

  factory FlipLongHashesResponse.fromJson(Map<String, dynamic> json) =>
      FlipLongHashesResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: List<FlipLongHashesResponseResult>.from(json["result"]
            .map((x) => FlipLongHashesResponseResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class FlipLongHashesResponseResult {
  FlipLongHashesResponseResult({
    this.hash,
    this.ready,
    this.extra,
    this.available,
  });

  String hash;
  bool ready;
  bool extra;
  bool available;

  factory FlipLongHashesResponseResult.fromJson(Map<String, dynamic> json) =>
      FlipLongHashesResponseResult(
        hash: json["hash"],
        ready: json["ready"],
        extra: json["extra"],
        available: json["available"],
      );

  Map<String, dynamic> toJson() => {
        "hash": hash,
        "ready": ready,
        "extra": extra,
        "available": available,
      };
}
