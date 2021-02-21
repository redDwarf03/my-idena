// To parse this JSON data, do
//
//     final contractReadDataRequest = contractReadDataRequestFromJson(jsonString);

import 'dart:convert';

ContractReadDataRequest contractReadDataRequestFromJson(String str) => ContractReadDataRequest.fromJson(json.decode(str));

String contractReadDataRequestToJson(ContractReadDataRequest data) => json.encode(data.toJson());

class ContractReadDataRequest {
    ContractReadDataRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<String> params;
    int id;
    String key;

    static const METHOD_NAME = "contract_readData";

    factory ContractReadDataRequest.fromJson(Map<String, dynamic> json) => ContractReadDataRequest(
        method: json["method"],
        params: List<String>.from(json["params"].map((x) => x)),
        id: json["id"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "params": List<dynamic>.from(params.map((x) => x)),
        "id": id,
        "key": key,
    };
}
