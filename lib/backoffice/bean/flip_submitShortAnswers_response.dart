// To parse this JSON data, do
//
//     final flipSubmitShortAnswersResponse = flipSubmitShortAnswersResponseFromJson(jsonString);

import 'dart:convert';

FlipSubmitShortAnswersResponse flipSubmitShortAnswersResponseFromJson(String str) => FlipSubmitShortAnswersResponse.fromJson(json.decode(str));

String flipSubmitShortAnswersResponseToJson(FlipSubmitShortAnswersResponse data) => json.encode(data.toJson());

class FlipSubmitShortAnswersResponse {
    FlipSubmitShortAnswersResponse({
        this.jsonrpc,
        this.id,
        this.result,
        this.error,
    });

    String jsonrpc;
    int id;
    Error error;
    Result result;

    factory FlipSubmitShortAnswersResponse.fromJson(Map<String, dynamic> json) => FlipSubmitShortAnswersResponse(
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
