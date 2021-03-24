// @dart=2.9
// To parse this JSON data, do
//
//     final contractDeployResponse = contractDeployResponseFromJson(jsonString);

import 'dart:convert';

ContractDeployResponse contractDeployResponseFromJson(String str) =>
    ContractDeployResponse.fromJson(json.decode(str));

String contractDeployResponseToJson(ContractDeployResponse data) =>
    json.encode(data.toJson());

class ContractDeployResponse {
  ContractDeployResponse({
    this.jsonrpc,
    this.id,
    this.result,
    this.error,
  });

  String jsonrpc;
  int id;
  String result;
  ContractDeployResponseError error;

  factory ContractDeployResponse.fromJson(Map<String, dynamic> json) =>
      ContractDeployResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"],
        error: json["error"] == null
            ? json["error"]
            : ContractDeployResponseError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result,
        "error": error.toJson(),
      };
}

class ContractDeployResponseError {
  ContractDeployResponseError({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory ContractDeployResponseError.fromJson(Map<String, dynamic> json) =>
      ContractDeployResponseError(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
