// To parse this JSON data, do
//
//     final simplePricePkrResponse = simplePricePkrResponseFromJson(jsonString);

import 'dart:convert';

SimplePricePkrResponse simplePricePkrResponseFromJson(String str) => SimplePricePkrResponse.fromJson(json.decode(str));

String simplePricePkrResponseToJson(SimplePricePkrResponse data) => json.encode(data.toJson());

class SimplePricePkrResponse {
    SimplePricePkrResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePricePkrResponse.fromJson(Map<String, dynamic> json) => SimplePricePkrResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.pkr,
    });

    double pkr;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        pkr: json["pkr"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "pkr": pkr,
    };
}
