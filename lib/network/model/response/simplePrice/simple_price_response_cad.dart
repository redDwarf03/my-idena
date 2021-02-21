// To parse this JSON data, do
//
//     final simplePriceCadResponse = simplePriceCadResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceCadResponse simplePriceCadResponseFromJson(String str) => SimplePriceCadResponse.fromJson(json.decode(str));

String simplePriceCadResponseToJson(SimplePriceCadResponse data) => json.encode(data.toJson());

class SimplePriceCadResponse {
    SimplePriceCadResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceCadResponse.fromJson(Map<String, dynamic> json) => SimplePriceCadResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.cad,
    });

    double cad;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        cad: json["cad"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "cad": cad,
    };
}
