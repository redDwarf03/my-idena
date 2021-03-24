// @dart=2.9
// To parse this JSON data, do
//
//     final dnaBecomeOfflineRequest = dnaBecomeOfflineRequestFromJson(jsonString);

import 'dart:convert';

DnaBecomeOfflineRequest dnaBecomeOfflineRequestFromJson(String str) => DnaBecomeOfflineRequest.fromJson(json.decode(str));

String dnaBecomeOfflineRequestToJson(DnaBecomeOfflineRequest data) => json.encode(data.toJson());

class DnaBecomeOfflineRequest {
    DnaBecomeOfflineRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<Param> params;
    int id;
    String key;

    static const METHOD_NAME = "dna_becomeOffline";

    factory DnaBecomeOfflineRequest.fromJson(Map<String, dynamic> json) => DnaBecomeOfflineRequest(
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
        this.nonce,
        this.epoch,
    });

    dynamic nonce;
    dynamic epoch;

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        nonce: json["nonce"],
        epoch: json["epoch"],
    );

    Map<String, dynamic> toJson() => {
        "nonce": nonce,
        "epoch": epoch,
    };
}

