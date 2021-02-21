// To parse this JSON data, do
//
//     final contractEstimateDeployResponse = contractEstimateDeployResponseFromJson(jsonString);

import 'dart:convert';

ContractEstimateDeployResponse contractEstimateDeployResponseFromJson(
        String str) =>
    ContractEstimateDeployResponse.fromJson(json.decode(str));

String contractEstimateDeployResponseToJson(
        ContractEstimateDeployResponse data) =>
    json.encode(data.toJson());

class ContractEstimateDeployResponse {
  ContractEstimateDeployResponse({
    this.jsonrpc,
    this.id,
    this.result,
    this.error,
  });

  String jsonrpc;
  int id;
  ContractEstimateDeployResponseResult result;
  ContractEstimateDeployResponseError error;

  factory ContractEstimateDeployResponse.fromJson(Map<String, dynamic> json) =>
      ContractEstimateDeployResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: json["result"] == null
            ? null
            : ContractEstimateDeployResponseResult.fromJson(json["result"]),
        error: json["error"] == null
            ? null
            : ContractEstimateDeployResponseError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
        "error": error.toJson(),
      };
}

class ContractEstimateDeployResponseResult {
  ContractEstimateDeployResponseResult({
    this.contract,
    this.method,
    this.success,
    this.gasUsed,
    this.txHash,
    this.error,
    this.gasCost,
    this.txFee,
  });

  String contract;
  String method;
  bool success;
  int gasUsed;
  String txHash;
  String error;
  String gasCost;
  String txFee;

  factory ContractEstimateDeployResponseResult.fromJson(
          Map<String, dynamic> json) =>
      ContractEstimateDeployResponseResult(
        contract: json["contract"],
        method: json["method"],
        success: json["success"],
        gasUsed: json["gasUsed"],
        txHash: json["txHash"],
        error: json["error"],
        gasCost: json["gasCost"],
        txFee: json["txFee"],
      );

  Map<String, dynamic> toJson() => {
        "contract": contract,
        "method": method,
        "success": success,
        "gasUsed": gasUsed,
        "txHash": txHash,
        "error": error,
        "gasCost": gasCost,
        "txFee": txFee,
      };
}

class ContractEstimateDeployResponseError {
  ContractEstimateDeployResponseError({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory ContractEstimateDeployResponseError.fromJson(
          Map<String, dynamic> json) =>
      ContractEstimateDeployResponseError(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
