// To parse this JSON data, do
//
//     final contractCallResponse = contractCallResponseFromJson(jsonString);

import 'dart:convert';

ContractCallResponse contractCallResponseFromJson(String str) =>
    ContractCallResponse.fromJson(json.decode(str));

String contractCallResponseToJson(ContractCallResponse data) =>
    json.encode(data.toJson());

class ContractCallResponse {
  ContractCallResponse({
    this.jsonrpc,
    this.id,
    this.result,
    this.error,
  });

  String jsonrpc;
  int id;
  String result;
  ContractCallResponseError error;

  factory ContractCallResponse.fromJson(Map<String, dynamic> json) =>
      ContractCallResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"],
        error: json["error"] == null ? null : ContractCallResponseError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result,
        "error": error.toJson(),
      };
}

class ContractCallResponseError {
  ContractCallResponseError({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory ContractCallResponseError.fromJson(Map<String, dynamic> json) =>
      ContractCallResponseError(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
