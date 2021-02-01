// To parse this JSON data, do
//
//     final bcnSendRawTxResponse = bcnSendRawTxResponseFromJson(jsonString);

import 'dart:convert';

BcnSendRawTxResponse bcnSendRawTxResponseFromJson(String str) => BcnSendRawTxResponse.fromJson(json.decode(str));

String bcnSendRawTxResponseToJson(BcnSendRawTxResponse data) => json.encode(data.toJson());

class BcnSendRawTxResponse {
    BcnSendRawTxResponse({
        this.jsonrpc,
        this.id,
        this.error,
    });

    String jsonrpc;
    int id;
    BcnSendRawTxResponseError error;

    factory BcnSendRawTxResponse.fromJson(Map<String, dynamic> json) => BcnSendRawTxResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        error: BcnSendRawTxResponseError.fromJson(json["error"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "error": error.toJson(),
    };
}

class BcnSendRawTxResponseError {
    BcnSendRawTxResponseError({
        this.code,
        this.message,
    });

    int code;
    String message;

    factory BcnSendRawTxResponseError.fromJson(Map<String, dynamic> json) => BcnSendRawTxResponseError(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
    };
}
