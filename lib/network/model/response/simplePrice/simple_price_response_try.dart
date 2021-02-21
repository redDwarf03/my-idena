// To parse this JSON data, do
//
//     final simplePriceTryResponse = simplePriceTryResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceTryResponse simplePriceTryResponseFromJson(String str) => SimplePriceTryResponse.fromJson(json.decode(str));

String simplePriceTryResponseToJson(SimplePriceTryResponse data) => json.encode(data.toJson());

class SimplePriceTryResponse {
    SimplePriceTryResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceTryResponse.fromJson(Map<String, dynamic> json) => SimplePriceTryResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.tryl,
    });

    double tryl;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        tryl: json["try"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "try": tryl,
    };
}
