// To parse this JSON data, do
//
//     final dnaSendInviteResponse = dnaSendInviteResponseFromJson(jsonString);

import 'dart:convert';

DnaSendInviteResponse dnaSendInviteResponseFromJson(String str) => DnaSendInviteResponse.fromJson(json.decode(str));

String dnaSendInviteResponseToJson(DnaSendInviteResponse data) => json.encode(data.toJson());

class DnaSendInviteResponse {
    DnaSendInviteResponse({
        this.jsonrpc,
        this.id,
        this.result,
        this.error,
    });

    String jsonrpc;
    int id;
    DnaSendInviteResponseResult result;
    DnaSendInviteResponseError error;

    factory DnaSendInviteResponse.fromJson(Map<String, dynamic> json) => DnaSendInviteResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"] == null ? null : DnaSendInviteResponseResult.fromJson(json["result"]),
        error: json["error"] == null ? null : DnaSendInviteResponseError.fromJson(json["error"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
        "error": error.toJson(),
    };
}

class DnaSendInviteResponseResult {
    DnaSendInviteResponseResult({
        this.hash,
        this.receiver,
        this.key,
    });

    String hash;
    String receiver;
    String key;

    factory DnaSendInviteResponseResult.fromJson(Map<String, dynamic> json) => DnaSendInviteResponseResult(
        hash: json["hash"],
        receiver: json["receiver"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "hash": hash,
        "receiver": receiver,
        "key": key,
    };
}


class DnaSendInviteResponseError {
    DnaSendInviteResponseError({
        this.code,
        this.message,
    });

    int code;
    String message;

    factory DnaSendInviteResponseError.fromJson(Map<String, dynamic> json) => DnaSendInviteResponseError(
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
    };
}
