// @dart=2.9
// To parse this JSON data, do
//
//     final dnaIdentityRequest = dnaIdentityRequestFromJson(jsonString);

import 'dart:convert';

DnaIdentityRequest dnaIdentityRequestFromJson(String str) => DnaIdentityRequest.fromJson(json.decode(str));

String dnaIdentityRequestToJson(DnaIdentityRequest data) => json.encode(data.toJson());

class DnaIdentityRequest {
    DnaIdentityRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    static const String METHOD_NAME = "dna_identity";

    String method;
    List<String> params;
    int id;
    String key;

    factory DnaIdentityRequest.fromJson(Map<String, dynamic> json) => DnaIdentityRequest(
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
