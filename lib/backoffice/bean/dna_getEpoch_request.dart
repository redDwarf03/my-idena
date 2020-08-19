// To parse this JSON data, do
//
//     final dnaGetEpochRequest = dnaGetEpochRequestFromJson(jsonString);

import 'dart:convert';

DnaGetEpochRequest dnaGetEpochRequestFromJson(String str) => DnaGetEpochRequest.fromJson(json.decode(str));

String dnaGetEpochRequestToJson(DnaGetEpochRequest data) => json.encode(data.toJson());

class DnaGetEpochRequest {
    DnaGetEpochRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<dynamic> params;
    int id;
    String key;

    static const METHOD_NAME = "dna_epoch";

    factory DnaGetEpochRequest.fromJson(Map<String, dynamic> json) => DnaGetEpochRequest(
        method: json["method"],
        params: List<dynamic>.from(json["params"].map((x) => x)),
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
