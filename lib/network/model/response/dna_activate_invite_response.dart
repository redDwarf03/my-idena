// @dart=2.9
// To parse this JSON data, do
//
//     final dnaActivateInviteResponse = dnaActivateInviteResponseFromJson(jsonString);

import 'dart:convert';

DnaActivateInviteResponse dnaActivateInviteResponseFromJson(String str) => DnaActivateInviteResponse.fromJson(json.decode(str));

String dnaActivateInviteResponseToJson(DnaActivateInviteResponse data) => json.encode(data.toJson());

class DnaActivateInviteResponse {
    DnaActivateInviteResponse({
        this.jsonrpc,
        this.id,
        this.result,
        this.error,
    });

    String jsonrpc;
    int id;
    DnaActivateInviteResponseError error;
    String result;

    factory DnaActivateInviteResponse.fromJson(Map<String, dynamic> json) => DnaActivateInviteResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"] == null ? null : json["result"],
        error: json["error"] == null ? null : DnaActivateInviteResponseError.fromJson(json["error"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result,
        "error": error.toJson(),
    };
}

class DnaActivateInviteResponseError {
    DnaActivateInviteResponseError({
        this.code,
        this.message,
    });

    int code;
    String message;

    factory DnaActivateInviteResponseError.fromJson(Map<String, dynamic> json) => DnaActivateInviteResponseError(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
    };
}

class DnaActivateInviteResponseResult
{

}
