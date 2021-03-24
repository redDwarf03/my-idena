// @dart=2.9
// To parse this JSON data, do
//
//     final dnaSignInResponse = dnaSignInResponseFromJson(jsonString);

import 'dart:convert';

DnaSignInResponse dnaSignInResponseFromJson(String str) => DnaSignInResponse.fromJson(json.decode(str));

String dnaSignInResponseToJson(DnaSignInResponse data) => json.encode(data.toJson());

class DnaSignInResponse {
    DnaSignInResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    String result;

    factory DnaSignInResponse.fromJson(Map<String, dynamic> json) => DnaSignInResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result,
    };
}
