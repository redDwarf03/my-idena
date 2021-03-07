// To parse this JSON data, do
//
//     final contractIterateMapRequest = contractIterateMapRequestFromJson(jsonString);

import 'dart:convert';

ContractIterateMapRequest contractIterateMapRequestFromJson(String str) =>
    ContractIterateMapRequest.fromJson(json.decode(str));

String contractIterateMapRequestToJson(ContractIterateMapRequest data) =>
    json.encode(data.toJson());

class ContractIterateMapRequest {
  ContractIterateMapRequest({
    this.method,
    this.params,
    this.id,
    this.key,
  });

  static const METHOD_NAME = "contract_iterateMap";

  String method;
  List<dynamic> params;
  int id;
  String key;

  factory ContractIterateMapRequest.fromJson(Map<String, dynamic> json) =>
      ContractIterateMapRequest(
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
