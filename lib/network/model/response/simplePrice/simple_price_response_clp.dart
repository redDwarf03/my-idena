// To parse this JSON data, do
//
//     final simplePriceClpResponse = simplePriceClpResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceClpResponse simplePriceClpResponseFromJson(String str) => SimplePriceClpResponse.fromJson(json.decode(str));

String simplePriceClpResponseToJson(SimplePriceClpResponse data) => json.encode(data.toJson());

class SimplePriceClpResponse {
    SimplePriceClpResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceClpResponse.fromJson(Map<String, dynamic> json) => SimplePriceClpResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.clp,
    });

    double clp;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        clp: json["clp"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "clp": clp,
    };
}
