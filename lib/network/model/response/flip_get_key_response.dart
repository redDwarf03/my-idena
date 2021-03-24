// @dart=2.9
// To parse this JSON data, do
//
//     final flipGetKeyResponse = flipGetKeyResponseFromJson(jsonString);

import 'dart:convert';

FlipGetKeyResponse flipGetKeyResponseFromJson(String str) => FlipGetKeyResponse.fromJson(json.decode(str));

String flipGetKeyResponseToJson(FlipGetKeyResponse data) => json.encode(data.toJson());

class FlipGetKeyResponse {
    FlipGetKeyResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    Result result;

    factory FlipGetKeyResponse.fromJson(Map<String, dynamic> json) => FlipGetKeyResponse(
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
        this.publicKey,
        this.privateKey,
    });

    String publicKey;
    String privateKey;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        publicKey: json["publicKey"],
        privateKey: json["privateKey"],
    );

    Map<String, dynamic> toJson() => {
        "publicKey": publicKey,
        "privateKey": privateKey,
    };
}
