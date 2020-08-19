// To parse this JSON data, do
//
//     final flipGetResponse = flipGetResponseFromJson(jsonString);

import 'dart:convert';

FlipGetResponse flipGetResponseFromJson(String str) => FlipGetResponse.fromJson(json.decode(str));

String flipGetResponseToJson(FlipGetResponse data) => json.encode(data.toJson());

class FlipGetResponse {
    FlipGetResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    Result result;

    factory FlipGetResponse.fromJson(Map<String, dynamic> json) => FlipGetResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
    };
}

class Result {
    Result({
        this.hex,
        this.privateHex,
        this.publicHex,
    });

    String hex;
    String privateHex;
    String publicHex;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        hex: json["hex"],
        privateHex: json["privateHex"],
        publicHex: json["publicHex"],
    );

    Map<String, dynamic> toJson() => {
        "hex": hex,
        "privateHex": privateHex,
        "publicHex": publicHex,
    };
}
