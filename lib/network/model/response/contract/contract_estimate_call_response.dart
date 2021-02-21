// To parse this JSON data, do
//
//     final contractEstimateCallResponse = contractEstimateCallResponseFromJson(jsonString);

import 'dart:convert';

ContractEstimateCallResponse contractEstimateCallResponseFromJson(String str) => ContractEstimateCallResponse.fromJson(json.decode(str));

String contractEstimateCallResponseToJson(ContractEstimateCallResponse data) => json.encode(data.toJson());

class ContractEstimateCallResponse {
    ContractEstimateCallResponse({
        this.jsonrpc,
        this.id,
        this.error,
    });

    String jsonrpc;
    int id;
    ContractEstimateCallResponseError error;

    factory ContractEstimateCallResponse.fromJson(Map<String, dynamic> json) => ContractEstimateCallResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        error: json["error"] == null ? null : ContractEstimateCallResponseError.fromJson(json["error"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "error": error.toJson(),
    };
}

class ContractEstimateCallResponseError {
    ContractEstimateCallResponseError({
        this.code,
        this.message,
    });

    int code;
    String message;

    factory ContractEstimateCallResponseError.fromJson(Map<String, dynamic> json) => ContractEstimateCallResponseError(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
    };
}
