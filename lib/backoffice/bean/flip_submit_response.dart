  // To parse this JSON data, do
//
//     final flipSubmitResponse = flipSubmitResponseFromJson(jsonString);

import 'dart:convert';

FlipSubmitResponse flipSubmitResponseFromJson(String str) => FlipSubmitResponse.fromJson(json.decode(str));

String flipSubmitResponseToJson(FlipSubmitResponse data) => json.encode(data.toJson());

class FlipSubmitResponse {
    FlipSubmitResponse({
        this.jsonrpc,
        this.id,
        this.error,
        this.result,
    });

    String jsonrpc;
    int id;
    Error error;
    Result result;

    factory FlipSubmitResponse.fromJson(Map<String, dynamic> json) => FlipSubmitResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        error: json["error"] != null ? Error.fromJson(json["error"]) : null,
        result: json["result"] != null ? Result.fromJson(json["result"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "error": error.toJson(),
        "result": result.toJson(),
    };
}

class Error {
    Error({
        this.code,
        this.message,
    });

    int code;
    String message;

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
    };
}


class Result {
    Result({
        this.txHash,
        this.hash,
    });

    String txHash;
    String hash;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        txHash: json["txHash"],
        hash: json["hash"],
    );

    Map<String, dynamic> toJson() => {
        "txHash": txHash,
        "hash": hash,
    };
}