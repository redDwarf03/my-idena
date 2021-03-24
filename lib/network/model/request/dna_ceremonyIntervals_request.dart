// @dart=2.9
// To parse this JSON data, do
//
//     final dnaCeremonyIntervalsRequest = dnaCeremonyIntervalsRequestFromJson(jsonString);

import 'dart:convert';

DnaCeremonyIntervalsRequest dnaCeremonyIntervalsRequestFromJson(String str) => DnaCeremonyIntervalsRequest.fromJson(json.decode(str));

String dnaCeremonyIntervalsRequestToJson(DnaCeremonyIntervalsRequest data) => json.encode(data.toJson());

class DnaCeremonyIntervalsRequest {
    DnaCeremonyIntervalsRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<dynamic> params;
    int id;
    String key;

    static const METHOD_NAME = "dna_ceremonyIntervals";

    factory DnaCeremonyIntervalsRequest.fromJson(Map<String, dynamic> json) => DnaCeremonyIntervalsRequest(
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
