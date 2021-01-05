// To parse this JSON data, do
//
//     final dnaGetEpochResponse = dnaGetEpochResponseFromJson(jsonString);

import 'dart:convert';

DnaGetEpochResponse dnaGetEpochResponseFromJson(String str) =>
    DnaGetEpochResponse.fromJson(json.decode(str));

String dnaGetEpochResponseToJson(DnaGetEpochResponse data) =>
    json.encode(data.toJson());

class DnaGetEpochResponse {
  DnaGetEpochResponse({
    this.jsonrpc,
    this.id,
    this.result,
    this.error,
  });

  String jsonrpc;
  int id;
  DnaGetEpochResponseResult result;
  DnaGetEpochResponseError error;

  factory DnaGetEpochResponse.fromJson(Map<String, dynamic> json) =>
      DnaGetEpochResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        error: json["error"] != null
            ? DnaGetEpochResponseError.fromJson(json["error"])
            : null,
        result: json["result"] != null
            ? DnaGetEpochResponseResult.fromJson(json["result"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
        "error": error.toJson(),
      };
}

class DnaGetEpochResponseError {
  DnaGetEpochResponseError({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory DnaGetEpochResponseError.fromJson(Map<String, dynamic> json) =>
      DnaGetEpochResponseError(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}

class DnaGetEpochResponseResult {
  DnaGetEpochResponseResult({
    this.epoch,
    this.nextValidation,
    this.currentPeriod,
    this.currentValidationStart,
  });

  int epoch;
  DateTime nextValidation;
  String currentPeriod;
  DateTime currentValidationStart;

  factory DnaGetEpochResponseResult.fromJson(Map<String, dynamic> json) =>
      DnaGetEpochResponseResult(
        epoch: json["epoch"],
        nextValidation: DateTime.parse(json["nextValidation"]),
        currentPeriod: json["currentPeriod"],
        currentValidationStart: DateTime.parse(json["currentValidationStart"]),
      );

  Map<String, dynamic> toJson() => {
        "epoch": epoch,
        "nextValidation": nextValidation.toIso8601String(),
        "currentPeriod": currentPeriod,
        "currentValidationStart": currentValidationStart.toIso8601String(),
      };
}
