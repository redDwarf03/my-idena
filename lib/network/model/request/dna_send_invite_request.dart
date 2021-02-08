// To parse this JSON data, do
//
//     final dnaSendInviteRequest = dnaSendInviteRequestFromJson(jsonString);

import 'dart:convert';

DnaSendInviteRequest dnaSendInviteRequestFromJson(String str) =>
    DnaSendInviteRequest.fromJson(json.decode(str));

String dnaSendInviteRequestToJson(DnaSendInviteRequest data) =>
    json.encode(data.toJson());

class DnaSendInviteRequest {
  DnaSendInviteRequest({
    this.method,
    this.params,
    this.id,
    this.key,
  });

  String method;
  List<Param> params;
  int id;
  String key;

  static const String METHOD_NAME = "dna_sendInvite";

  factory DnaSendInviteRequest.fromJson(Map<String, dynamic> json) =>
      DnaSendInviteRequest(
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
    this.amount,
    this.nonce,
    this.epoch,
  });

  String to;
  String amount;
  int nonce;
  int epoch;

  factory Param.fromJson(Map<String, dynamic> json) => Param(
        to: json["to"],
        amount: json["amount"],
        nonce: json["nonce"],
        epoch: json["epoch"],
      );

  Map<String, dynamic> toJson() => {
        "to": to,
        "amount": amount,
        "nonce": nonce,
        "epoch": epoch,
      };
}
