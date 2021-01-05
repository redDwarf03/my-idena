// To parse this JSON data, do
//
//     final dnaCeremonyIntervalsResponse = dnaCeremonyIntervalsResponseFromJson(jsonString);

import 'dart:convert';

DnaCeremonyIntervalsResponse dnaCeremonyIntervalsResponseFromJson(String str) =>
    DnaCeremonyIntervalsResponse.fromJson(json.decode(str));

String dnaCeremonyIntervalsResponseToJson(DnaCeremonyIntervalsResponse data) =>
    json.encode(data.toJson());

class DnaCeremonyIntervalsResponse {
  DnaCeremonyIntervalsResponse({
    this.jsonrpc,
    this.id,
    this.result,
    this.error,
  });

  String jsonrpc;
  int id;
  DnaCeremonyIntervalsResponseResult result;
  DnaCeremonyIntervalsResponseError error;

  factory DnaCeremonyIntervalsResponse.fromJson(Map<String, dynamic> json) =>
      DnaCeremonyIntervalsResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        error: json["error"] != null
            ? DnaCeremonyIntervalsResponseError.fromJson(json["error"])
            : null,
        result: json["result"] != null
            ? DnaCeremonyIntervalsResponseResult.fromJson(json["result"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
        "error": error.toJson(),
      };
}

class DnaCeremonyIntervalsResponseError {
  DnaCeremonyIntervalsResponseError({
    this.code,
    this.message,
  });

  int code;
  String message;

  factory DnaCeremonyIntervalsResponseError.fromJson(
          Map<String, dynamic> json) =>
      DnaCeremonyIntervalsResponseError(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}

class DnaCeremonyIntervalsResponseResult {
  DnaCeremonyIntervalsResponseResult({
    this.flipLotteryDuration,
    this.shortSessionDuration,
    this.longSessionDuration,
  });

  int flipLotteryDuration;
  int shortSessionDuration;
  int longSessionDuration;

  factory DnaCeremonyIntervalsResponseResult.fromJson(
          Map<String, dynamic> json) =>
      DnaCeremonyIntervalsResponseResult(
        flipLotteryDuration: json["FlipLotteryDuration"],
        shortSessionDuration: json["ShortSessionDuration"],
        longSessionDuration: json["LongSessionDuration"],
      );

  Map<String, dynamic> toJson() => {
        "FlipLotteryDuration": flipLotteryDuration,
        "ShortSessionDuration": shortSessionDuration,
        "LongSessionDuration": longSessionDuration,
      };
}
