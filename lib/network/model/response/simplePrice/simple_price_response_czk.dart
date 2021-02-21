// To parse this JSON data, do
//
//     final simplePriceCzkResponse = simplePriceCzkResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceCzkResponse simplePriceCzkResponseFromJson(String str) => SimplePriceCzkResponse.fromJson(json.decode(str));

String simplePriceCzkResponseToJson(SimplePriceCzkResponse data) => json.encode(data.toJson());

class SimplePriceCzkResponse {
    SimplePriceCzkResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceCzkResponse.fromJson(Map<String, dynamic> json) => SimplePriceCzkResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.czk,
    });

    double czk;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        czk: json["czk"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "czk": czk,
    };
}
