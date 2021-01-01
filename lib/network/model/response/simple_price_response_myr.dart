// To parse this JSON data, do
//
//     final simplePriceMyrResponse = simplePriceMyrResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceMyrResponse simplePriceMyrResponseFromJson(String str) => SimplePriceMyrResponse.fromJson(json.decode(str));

String simplePriceMyrResponseToJson(SimplePriceMyrResponse data) => json.encode(data.toJson());

class SimplePriceMyrResponse {
    SimplePriceMyrResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceMyrResponse.fromJson(Map<String, dynamic> json) => SimplePriceMyrResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.myr,
    });

    double myr;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        myr: json["myr"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "myr": myr,
    };
}
