// @dart=2.9
// To parse this JSON data, do
//
//     final contractUnsubscribeFromEventRequest = contractUnsubscribeFromEventRequestFromJson(jsonString);

import 'dart:convert';

ContractUnsubscribeFromEventRequest contractUnsubscribeFromEventRequestFromJson(String str) => ContractUnsubscribeFromEventRequest.fromJson(json.decode(str));

String contractUnsubscribeFromEventRequestToJson(ContractUnsubscribeFromEventRequest data) => json.encode(data.toJson());

class ContractUnsubscribeFromEventRequest {
    ContractUnsubscribeFromEventRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<String> params;
    int id;
    String key;

    static const METHOD_NAME = "contract_UnsubscribeFromEvent";

    factory ContractUnsubscribeFromEventRequest.fromJson(Map<String, dynamic> json) => ContractUnsubscribeFromEventRequest(
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
