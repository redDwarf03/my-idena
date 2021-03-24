// @dart=2.9
// To parse this JSON data, do
//
//     final dnaSignInRequest = dnaSignInRequestFromJson(jsonString);

import 'dart:convert';

DnaSignInRequest dnaSignInRequestFromJson(String str) => DnaSignInRequest.fromJson(json.decode(str));

String dnaSignInRequestToJson(DnaSignInRequest data) => json.encode(data.toJson());

class DnaSignInRequest {
    DnaSignInRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<String> params;
    int id;
    String key;

    static const METHOD_NAME = "dna_sign";

    factory DnaSignInRequest.fromJson(Map<String, dynamic> json) => DnaSignInRequest(
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
