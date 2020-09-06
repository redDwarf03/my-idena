// To parse this JSON data, do
//
//     final flipSubmitRequest = flipSubmitRequestFromJson(jsonString);

import 'dart:convert';

FlipSubmitRequest flipSubmitRequestFromJson(String str) => FlipSubmitRequest.fromJson(json.decode(str));

String flipSubmitRequestToJson(FlipSubmitRequest data) => json.encode(data.toJson());

class FlipSubmitRequest {
    FlipSubmitRequest({
        this.method,
        this.params,
        this.id,
    });

    String method;
    List<Param> params;
    int id;

    static const String METHOD_NAME = "flip_submit";

    factory FlipSubmitRequest.fromJson(Map<String, dynamic> json) => FlipSubmitRequest(
        method: json["method"],
        params: List<Param>.from(json["params"].map((x) => Param.fromJson(x))),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "params": List<dynamic>.from(params.map((x) => x.toJson())),
        "id": id,
    };
}

class Param {
    Param({
        this.publicHex,
        this.privateHex,
        this.pairId,
    });

    String publicHex;
    String privateHex;
    int pairId;

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        publicHex: json["publicHex"],
        privateHex: json["privateHex"],
        pairId: json["pairId"],
    );

    Map<String, dynamic> toJson() => {
        "publicHex": publicHex,
        "privateHex": privateHex,
        "pairId": pairId,
    };
}
