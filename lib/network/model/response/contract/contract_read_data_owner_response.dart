// To parse this JSON data, do
//
//     final contractReadDataOwnerResponse = contractReadDataOwnerResponseFromJson(jsonString);

import 'dart:convert';

ContractReadDataOwnerResponse contractReadDataOwnerResponseFromJson(String str) => ContractReadDataOwnerResponse.fromJson(json.decode(str));

String contractReadDataOwnerResponseToJson(ContractReadDataOwnerResponse data) => json.encode(data.toJson());

class ContractReadDataOwnerResponse {
    ContractReadDataOwnerResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    String result;

    factory ContractReadDataOwnerResponse.fromJson(Map<String, dynamic> json) => ContractReadDataOwnerResponse(
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
