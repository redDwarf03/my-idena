// To parse this JSON data, do
//
//     final simplePriceCnyResponse = simplePriceCnyResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceCnyResponse simplePriceCnyResponseFromJson(String str) => SimplePriceCnyResponse.fromJson(json.decode(str));

String simplePriceCnyResponseToJson(SimplePriceCnyResponse data) => json.encode(data.toJson());

class SimplePriceCnyResponse {
    SimplePriceCnyResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceCnyResponse.fromJson(Map<String, dynamic> json) => SimplePriceCnyResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.cny,
    });

    double cny;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        cny: json["cny"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "cny": cny,
    };
}
