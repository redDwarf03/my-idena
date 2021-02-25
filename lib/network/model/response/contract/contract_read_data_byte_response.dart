// To parse this JSON data, do
//
//     final contractReadDataByteResponse = contractReadDataByteResponseFromJson(jsonString);

import 'dart:convert';

ContractReadDataByteResponse contractReadDataByteResponseFromJson(String str) => ContractReadDataByteResponse.fromJson(json.decode(str));

String contractReadDataByteResponseToJson(ContractReadDataByteResponse data) => json.encode(data.toJson());

class ContractReadDataByteResponse {
    ContractReadDataByteResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    int result;

    factory ContractReadDataByteResponse.fromJson(Map<String, dynamic> json) => ContractReadDataByteResponse(
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
