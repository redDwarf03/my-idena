// To parse this JSON data, do
//
//     final dnaGetEpochResponse = dnaGetEpochResponseFromJson(jsonString);

import 'dart:convert';

DnaGetEpochResponse dnaGetEpochResponseFromJson(String str) => DnaGetEpochResponse.fromJson(json.decode(str));

String dnaGetEpochResponseToJson(DnaGetEpochResponse data) => json.encode(data.toJson());

class DnaGetEpochResponse {
    DnaGetEpochResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    Result result;

    factory DnaGetEpochResponse.fromJson(Map<String, dynamic> json) => DnaGetEpochResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
    };
}

class Result {
    Result({
        this.epoch,
        this.nextValidation,
        this.currentPeriod,
        this.currentValidationStart,
    });

    int epoch;
    DateTime nextValidation;
    String currentPeriod;
    DateTime currentValidationStart;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
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
