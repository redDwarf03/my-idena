// @dart=2.9
// To parse this JSON data, do
//
//     final contractTerminateResponse = contractTerminateResponseFromJson(jsonString);

import 'dart:convert';

ContractTerminateResponse contractTerminateResponseFromJson(String str) => ContractTerminateResponse.fromJson(json.decode(str));

String contractTerminateResponseToJson(ContractTerminateResponse data) => json.encode(data.toJson());

class ContractTerminateResponse {
    ContractTerminateResponse({
        this.jsonrpc,
        this.id,
        this.result,
        this.error,
    });

    String jsonrpc;
    int id;
    String result;
    ContractTerminateResponseError error;

    factory ContractTerminateResponse.fromJson(Map<String, dynamic> json) => ContractTerminateResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"],
        error: json["error"] == null ? null : ContractTerminateResponseError.fromJson(json["error"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result,
         "error": error.toJson(),
    };
}


class ContractTerminateResponseError {
    ContractTerminateResponseError({
        this.code,
        this.message,
    });

    int code;
    String message;

    factory ContractTerminateResponseError.fromJson(Map<String, dynamic> json) => ContractTerminateResponseError(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
    };
}
