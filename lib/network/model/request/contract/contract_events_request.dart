// @dart=2.9
// To parse this JSON data, do
//
//     final contractEventsRequest = contractEventsRequestFromJson(jsonString);

import 'dart:convert';

ContractEventsRequest contractEventsRequestFromJson(String str) => ContractEventsRequest.fromJson(json.decode(str));

String contractEventsRequestToJson(ContractEventsRequest data) => json.encode(data.toJson());

class ContractEventsRequest {
    ContractEventsRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<Param> params;
    int id;
    String key;

    static const METHOD_NAME = "contract_events";

    factory ContractEventsRequest.fromJson(Map<String, dynamic> json) => ContractEventsRequest(
        method: json["method"],
        params: List<Param>.from(json["params"].map((x) => Param.fromJson(x))),
        id: json["id"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "params": List<dynamic>.from(params.map((x) => x.toJson())),
        "id": id,
        "key": key,
    };
}

class Param {
    Param({
        this.contract,
    });

    String contract;

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        contract: json["contract"],
    );

    Map<String, dynamic> toJson() => {
        "contract": contract,
    };
}
