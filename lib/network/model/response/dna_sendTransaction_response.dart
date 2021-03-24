// @dart=2.9
// To parse this JSON data, do
//
//     final dnaSendTransactionResponse = dnaSendTransactionResponseFromJson(jsonString);

import 'dart:convert';

DnaSendTransactionResponse dnaSendTransactionResponseFromJson(String str) => DnaSendTransactionResponse.fromJson(json.decode(str));

String dnaSendTransactionResponseToJson(DnaSendTransactionResponse data) => json.encode(data.toJson());

class DnaSendTransactionResponse {
    DnaSendTransactionResponse({
        this.jsonrpc,
        this.id,
        this.result,
        this.error,
    });

    String jsonrpc;
    int id;
    String result;
    DnaSendTransactionResponseError error;

    factory DnaSendTransactionResponse.fromJson(Map<String, dynamic> json) => DnaSendTransactionResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"] == null ? "" : json["result"],
        error: json["error"] == null ? null : DnaSendTransactionResponseError.fromJson(json["error"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result,
        "error": error.toJson(),
    };
}


class DnaSendTransactionResponseError {
    DnaSendTransactionResponseError({
        this.code,
        this.message,
    });

    int code;
    String message;

    factory DnaSendTransactionResponseError.fromJson(Map<String, dynamic> json) => DnaSendTransactionResponseError(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
    };
}

