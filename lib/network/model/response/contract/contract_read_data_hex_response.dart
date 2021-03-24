// @dart=2.9
// To parse this JSON data, do
//
//     final contractReadDataHexResponse = contractReadDataHexResponseFromJson(jsonString);

import 'dart:convert';

ContractReadDataHexResponse contractReadDataHexResponseFromJson(String str) => ContractReadDataHexResponse.fromJson(json.decode(str));

String contractReadDataHexResponseToJson(ContractReadDataHexResponse data) => json.encode(data.toJson());

class ContractReadDataHexResponse {
    ContractReadDataHexResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    String result;

    factory ContractReadDataHexResponse.fromJson(Map<String, dynamic> json) => ContractReadDataHexResponse(
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
