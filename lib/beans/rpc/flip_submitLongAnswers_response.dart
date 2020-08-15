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
        this.error,
    });

    String jsonrpc;
    int id;
    Error error;

    factory FlipSubmitLongAnswersResponse.fromJson(Map<String, dynamic> json) => FlipSubmitLongAnswersResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        error: Error.fromJson(json["error"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "error": error.toJson(),
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
