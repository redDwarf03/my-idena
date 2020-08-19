// To parse this JSON data, do
//
//     final getFlipRawResponse = getFlipRawResponseFromJson(jsonString);

import 'dart:convert';

GetFlipRawResponse getFlipRawResponseFromJson(String str) => GetFlipRawResponse.fromJson(json.decode(str));

String getFlipRawResponseToJson(GetFlipRawResponse data) => json.encode(data.toJson());

class GetFlipRawResponse {
    GetFlipRawResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    Result result;

    factory GetFlipRawResponse.fromJson(Map<String, dynamic> json) => GetFlipRawResponse(
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
        this.publicHex,
        this.privateHex,
    });

    String publicHex;
    String privateHex;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        publicHex: json["publicHex"],
        privateHex: json["privateHex"],
    );

    Map<String, dynamic> toJson() => {
        "publicHex": publicHex,
        "privateHex": privateHex,
    };
}
