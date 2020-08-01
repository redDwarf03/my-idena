// To parse this JSON data, do
//
//     final flipLongHashesResponse = flipLongHashesResponseFromJson(jsonString);

import 'dart:convert';

FlipLongHashesResponse flipLongHashesResponseFromJson(String str) => FlipLongHashesResponse.fromJson(json.decode(str));

String flipLongHashesResponseToJson(FlipLongHashesResponse data) => json.encode(data.toJson());

class FlipLongHashesResponse {
    FlipLongHashesResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    List<Result> result;

    factory FlipLongHashesResponse.fromJson(Map<String, dynamic> json) => FlipLongHashesResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.hash,
        this.ready,
        this.extra,
        this.available,
    });

    String hash;
    bool ready;
    bool extra;
    bool available;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
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
