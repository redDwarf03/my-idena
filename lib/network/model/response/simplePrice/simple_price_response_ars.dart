// To parse this JSON data, do
//
//     final simplePriceArsResponse = simplePriceArsResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceArsResponse simplePriceArsResponseFromJson(String str) => SimplePriceArsResponse.fromJson(json.decode(str));

String simplePriceArsResponseToJson(SimplePriceArsResponse data) => json.encode(data.toJson());

class SimplePriceArsResponse {
    SimplePriceArsResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceArsResponse.fromJson(Map<String, dynamic> json) => SimplePriceArsResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.ars,
    });

    double ars;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        ars: json["ars"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "ars": ars,
    };
}
