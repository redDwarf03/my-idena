// To parse this JSON data, do
//
//     final simplePriceEurResponse = simplePriceEurResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceEurResponse simplePriceEurResponseFromJson(String str) => SimplePriceEurResponse.fromJson(json.decode(str));

String simplePriceEurResponseToJson(SimplePriceEurResponse data) => json.encode(data.toJson());

class SimplePriceEurResponse {
    SimplePriceEurResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceEurResponse.fromJson(Map<String, dynamic> json) => SimplePriceEurResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.eur,
    });

    double eur;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        eur: json["eur"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "eur": eur,
    };
}
