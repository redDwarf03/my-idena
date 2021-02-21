// To parse this JSON data, do
//
//     final simplePriceInrResponse = simplePriceInrResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceInrResponse simplePriceInrResponseFromJson(String str) => SimplePriceInrResponse.fromJson(json.decode(str));

String simplePriceInrResponseToJson(SimplePriceInrResponse data) => json.encode(data.toJson());

class SimplePriceInrResponse {
    SimplePriceInrResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceInrResponse.fromJson(Map<String, dynamic> json) => SimplePriceInrResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.inr,
    });

    double inr;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        inr: json["inr"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "inr": inr,
    };
}
