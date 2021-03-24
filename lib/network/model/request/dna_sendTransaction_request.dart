// @dart=2.9
// To parse this JSON data, do
//
//     final dnaSendTransactionRequest = dnaSendTransactionRequestFromJson(jsonString);

import 'dart:convert';

DnaSendTransactionRequest dnaSendTransactionRequestFromJson(String str) => DnaSendTransactionRequest.fromJson(json.decode(str));

String dnaSendTransactionRequestToJson(DnaSendTransactionRequest data) => json.encode(data.toJson());

class DnaSendTransactionRequest {
    DnaSendTransactionRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<Param> params;
    int id;
    String key;

    static const METHOD_NAME = "dna_sendTransaction";

    factory DnaSendTransactionRequest.fromJson(Map<String, dynamic> json) => DnaSendTransactionRequest(
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
        this.from,
        this.to,
        this.amount,
        this.maxFee,
        this.tips,
        this.payload,
    });

    String from;
    String to;
    String amount;
    String maxFee;
    String tips;
    String payload;

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        from: json["from"],
        to: json["to"],
        amount: json["amount"],
        maxFee: json["maxFee"],
        tips: json["tips"],
        payload: json["payload"],
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "amount": amount,
        "maxFee": maxFee,
        "tips": tips,
        "payload": payload,
    };
}
