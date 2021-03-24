// @dart=2.9
// To parse this JSON data, do
//
//     final contractIterateMapResponse = contractIterateMapResponseFromJson(jsonString);

import 'dart:convert';

ContractIterateMapResponse contractIterateMapResponseFromJson(String str) => ContractIterateMapResponse.fromJson(json.decode(str));

String contractIterateMapResponseToJson(ContractIterateMapResponse data) => json.encode(data.toJson());

class ContractIterateMapResponse {
    ContractIterateMapResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    ContractIterateMapResponseResult result;

    factory ContractIterateMapResponse.fromJson(Map<String, dynamic> json) => ContractIterateMapResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: ContractIterateMapResponseResult.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
    };
}

class ContractIterateMapResponseResult {
    ContractIterateMapResponseResult({
        this.items,
        this.continuationToken,
    });

    List<ContractIterateMapResponseItem> items;
    String continuationToken;

    factory ContractIterateMapResponseResult.fromJson(Map<String, dynamic> json) => ContractIterateMapResponseResult(
        items: List<ContractIterateMapResponseItem>.from(json["items"].map((x) => ContractIterateMapResponseItem.fromJson(x))),
        continuationToken: json["continuationToken"],
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "continuationToken": continuationToken,
    };
}

class ContractIterateMapResponseItem {
    ContractIterateMapResponseItem({
        this.key,
        this.value,
    });

    String key;
    String value;

    factory ContractIterateMapResponseItem.fromJson(Map<String, dynamic> json) => ContractIterateMapResponseItem(
        key: json["key"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
    };
}
