// @dart=2.9
// To parse this JSON data, do
//
//     final dnaGetCoinbaseAddrRequest = dnaGetCoinbaseAddrRequestFromJson(jsonString);

import 'dart:convert';

DnaGetCoinbaseAddrRequest dnaGetCoinbaseAddrRequestFromJson(String str) => DnaGetCoinbaseAddrRequest.fromJson(json.decode(str));

String dnaGetCoinbaseAddrRequestToJson(DnaGetCoinbaseAddrRequest data) => json.encode(data.toJson());


class DnaGetCoinbaseAddrRequest {
    DnaGetCoinbaseAddrRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    static const METHOD_NAME = "dna_getCoinbaseAddr";

    String method;
    List<dynamic> params;
    int id;
    String key;

    factory DnaGetCoinbaseAddrRequest.fromJson(Map<String, dynamic> json) => DnaGetCoinbaseAddrRequest(
        method: METHOD_NAME,
        params: List<dynamic>.from(json["params"].map((x) => x)),
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
