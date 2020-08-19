// To parse this JSON data, do
//
//     final dnaCeremonyIntervalsResponse = dnaCeremonyIntervalsResponseFromJson(jsonString);

import 'dart:convert';

DnaCeremonyIntervalsResponse dnaCeremonyIntervalsResponseFromJson(String str) => DnaCeremonyIntervalsResponse.fromJson(json.decode(str));

String dnaCeremonyIntervalsResponseToJson(DnaCeremonyIntervalsResponse data) => json.encode(data.toJson());

class DnaCeremonyIntervalsResponse {
    DnaCeremonyIntervalsResponse({
        this.jsonrpc,
        this.id,
        this.result,
    });

    String jsonrpc;
    int id;
    Result result;

    factory DnaCeremonyIntervalsResponse.fromJson(Map<String, dynamic> json) => DnaCeremonyIntervalsResponse(
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
        this.flipLotteryDuration,
        this.shortSessionDuration,
        this.longSessionDuration,
    });

    int flipLotteryDuration;
    int shortSessionDuration;
    int longSessionDuration;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
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
