// To parse this JSON data, do
//
//     final simplePriceNokResponse = simplePriceNokResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceNokResponse simplePriceNokResponseFromJson(String str) => SimplePriceNokResponse.fromJson(json.decode(str));

String simplePriceNokResponseToJson(SimplePriceNokResponse data) => json.encode(data.toJson());

class SimplePriceNokResponse {
    SimplePriceNokResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceNokResponse.fromJson(Map<String, dynamic> json) => SimplePriceNokResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.nok,
    });

    double nok;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        nok: json["nok"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "nok": nok,
    };
}
