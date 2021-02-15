// To parse this JSON data, do
//
//     final contractGetStakeRequest = contractGetStakeRequestFromJson(jsonString);

import 'dart:convert';

ContractGetStakeRequest contractGetStakeRequestFromJson(String str) => ContractGetStakeRequest.fromJson(json.decode(str));

String contractGetStakeRequestToJson(ContractGetStakeRequest data) => json.encode(data.toJson());

class ContractGetStakeRequest {
    ContractGetStakeRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<String> params;
    int id;
    String key;

    static const METHOD_NAME = "contract_getStake";

    factory ContractGetStakeRequest.fromJson(Map<String, dynamic> json) => ContractGetStakeRequest(
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
