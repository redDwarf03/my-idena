// To parse this JSON data, do
//
//     final contractSubscribeToEventRequest = contractSubscribeToEventRequestFromJson(jsonString);

import 'dart:convert';

ContractSubscribeToEventRequest contractSubscribeToEventRequestFromJson(String str) => ContractSubscribeToEventRequest.fromJson(json.decode(str));

String contractSubscribeToEventRequestToJson(ContractSubscribeToEventRequest data) => json.encode(data.toJson());

class ContractSubscribeToEventRequest {
    ContractSubscribeToEventRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<String> params;
    int id;
    String key;

    static const METHOD_NAME = "contract_subscribeToEvent";

    factory ContractSubscribeToEventRequest.fromJson(Map<String, dynamic> json) => ContractSubscribeToEventRequest(
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
