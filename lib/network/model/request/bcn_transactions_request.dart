// @dart=2.9
// To parse this JSON data, do
//
//     final bcnTransactionsRequest = bcnTransactionsRequestFromJson(jsonString);

import 'dart:convert';

BcnTransactionsRequest bcnTransactionsRequestFromJson(String str) => BcnTransactionsRequest.fromJson(json.decode(str));

String bcnTransactionsRequestToJson(BcnTransactionsRequest data) => json.encode(data.toJson());

class BcnTransactionsRequest {
    BcnTransactionsRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<Param> params;
    int id;
    String key;

    static const METHOD_NAME = "bcn_transactions";

    factory BcnTransactionsRequest.fromJson(Map<String, dynamic> json) => BcnTransactionsRequest(
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
        this.address,
        this.count,
    });

    String address;
    int count;

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        address: json["address"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "count": count,
    };
}
