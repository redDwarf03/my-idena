// To parse this JSON data, do
//
//     final bcnFeePerGasResponse = bcnFeePerGasResponseFromJson(jsonString);

import 'dart:convert';

BcnFeePerGasResponse bcnFeePerGasResponseFromJson(String str) => BcnFeePerGasResponse.fromJson(json.decode(str));

String bcnFeePerGasResponseToJson(BcnFeePerGasResponse data) => json.encode(data.toJson());

class BcnFeePerGasResponse {
    BcnFeePerGasResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    int result;

    factory BcnFeePerGasResponse.fromJson(Map<String, dynamic> json) => BcnFeePerGasResponse(
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
