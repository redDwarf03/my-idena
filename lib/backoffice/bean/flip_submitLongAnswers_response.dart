// To parse this JSON data, do
//
//     final flipSubmitLongAnswersResponse = flipSubmitLongAnswersResponseFromJson(jsonString);

import 'dart:convert';

FlipSubmitLongAnswersResponse flipSubmitLongAnswersResponseFromJson(String str) => FlipSubmitLongAnswersResponse.fromJson(json.decode(str));

String flipSubmitLongAnswersResponseToJson(FlipSubmitLongAnswersResponse data) => json.encode(data.toJson());

class FlipSubmitLongAnswersResponse {
    FlipSubmitLongAnswersResponse({
        this.jsonrpc,
        this.id,
        this.result,
        this.error,
    });

    String jsonrpc;
    int id;
    Error error;
    Result result;

    factory FlipSubmitLongAnswersResponse.fromJson(Map<String, dynamic> json) => FlipSubmitLongAnswersResponse(
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
    });

    String txHash;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        txHash: json["txHash"],
    );

    Map<String, dynamic> toJson() => {
        "txHash": txHash,
    };    
}
