// To parse this JSON data, do
//
//     final contractReadDataTimestampResponse = contractReadDataTimestampResponseFromJson(jsonString);

import 'dart:convert';

ContractReadDataTimestampResponse contractReadDataTimestampResponseFromJson(String str) => ContractReadDataTimestampResponse.fromJson(json.decode(str));

String contractReadDataTimestampResponseToJson(ContractReadDataTimestampResponse data) => json.encode(data.toJson());

class ContractReadDataTimestampResponse {
    ContractReadDataTimestampResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    int result;

    factory ContractReadDataTimestampResponse.fromJson(Map<String, dynamic> json) => ContractReadDataTimestampResponse(
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
