// To parse this JSON data, do
//
//     final dnaActivateInviteRequest = dnaActivateInviteRequestFromJson(jsonString);

import 'dart:convert';

DnaActivateInviteRequest dnaActivateInviteRequestFromJson(String str) => DnaActivateInviteRequest.fromJson(json.decode(str));

String dnaActivateInviteRequestToJson(DnaActivateInviteRequest data) => json.encode(data.toJson());

class DnaActivateInviteRequest {
    DnaActivateInviteRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<Param> params;
    int id;
    String key;

  static const METHOD_NAME = "dna_activateInvite";

    factory DnaActivateInviteRequest.fromJson(Map<String, dynamic> json) => DnaActivateInviteRequest(
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
        this.to,
    });

    String to;

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        to: json["to"],
    );

    Map<String, dynamic> toJson() => {
        "to": to,
    };
}
