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
  });

  String jsonrpc;
  int id;
  DnaCeremonyIntervalsResponseResult result;

  factory DnaCeremonyIntervalsResponse.fromJson(Map<String, dynamic> json) =>
      DnaCeremonyIntervalsResponse(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: DnaCeremonyIntervalsResponseResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
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
