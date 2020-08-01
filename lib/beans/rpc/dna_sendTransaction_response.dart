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
    });

    String jsonrpc;
    int id;
    String result;

    factory DnaSendTransactionResponse.fromJson(Map<String, dynamic> json) => DnaSendTransactionResponse(
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
