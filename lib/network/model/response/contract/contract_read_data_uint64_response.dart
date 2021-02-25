// To parse this JSON data, do
//
//     final contractReadDataUint64Response = contractReadDataUint64ResponseFromJson(jsonString);

import 'dart:convert';

ContractReadDataUint64Response contractReadDataUint64ResponseFromJson(String str) => ContractReadDataUint64Response.fromJson(json.decode(str));

String contractReadDataUint64ResponseToJson(ContractReadDataUint64Response data) => json.encode(data.toJson());

class ContractReadDataUint64Response {
    ContractReadDataUint64Response({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    int result;

    factory ContractReadDataUint64Response.fromJson(Map<String, dynamic> json) => ContractReadDataUint64Response(
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
