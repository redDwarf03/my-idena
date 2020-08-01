// To parse this JSON data, do
//
//     final flipShortHashesResponse = flipShortHashesResponseFromJson(jsonString);

import 'dart:convert';

FlipShortHashesResponse flipShortHashesResponseFromJson(String str) => FlipShortHashesResponse.fromJson(json.decode(str));

String flipShortHashesResponseToJson(FlipShortHashesResponse data) => json.encode(data.toJson());

class FlipShortHashesResponse {
    FlipShortHashesResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    List<Result> result;

    factory FlipShortHashesResponse.fromJson(Map<String, dynamic> json) => FlipShortHashesResponse(
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
