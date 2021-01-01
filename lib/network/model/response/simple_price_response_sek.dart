// To parse this JSON data, do
//
//     final simplePriceSekResponse = simplePriceSekResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceSekResponse simplePriceSekResponseFromJson(String str) => SimplePriceSekResponse.fromJson(json.decode(str));

String simplePriceSekResponseToJson(SimplePriceSekResponse data) => json.encode(data.toJson());

class SimplePriceSekResponse {
    SimplePriceSekResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceSekResponse.fromJson(Map<String, dynamic> json) => SimplePriceSekResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.sek,
    });

    double sek;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        sek: json["sek"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "sek": sek,
    };
}
