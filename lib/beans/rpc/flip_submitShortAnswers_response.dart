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
        this.error,
    });

    String jsonrpc;
    int id;
    Error error;

    factory FlipSubmitShortAnswersResponse.fromJson(Map<String, dynamic> json) => FlipSubmitShortAnswersResponse(
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
