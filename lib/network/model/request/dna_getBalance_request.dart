// To parse this JSON data, do
//
//     final dnaGetBalanceRequest = dnaGetBalanceRequestFromJson(jsonString);

import 'dart:convert';

DnaGetBalanceRequest dnaGetBalanceRequestFromJson(String str) => DnaGetBalanceRequest.fromJson(json.decode(str));

String dnaGetBalanceRequestToJson(DnaGetBalanceRequest data) => json.encode(data.toJson());

class DnaGetBalanceRequest {
    DnaGetBalanceRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    static const METHOD_NAME = "dna_getBalance";

    String method;
    List<String> params;
    int id;
    String key;

    factory DnaGetBalanceRequest.fromJson(Map<String, dynamic> json) => DnaGetBalanceRequest(
        method: METHOD_NAME,
        params: List<String>.from(json["params"].map((x) => x)),
        id: json["id"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "method": METHOD_NAME,
        "params": List<dynamic>.from(params.map((x) => x)),
        "id": id,
        "key": key,
    };
}
