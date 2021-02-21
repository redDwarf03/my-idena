// To parse this JSON data, do
//
//     final simplePriceGbpResponse = simplePriceGbpResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceGbpResponse simplePriceGbpResponseFromJson(String str) => SimplePriceGbpResponse.fromJson(json.decode(str));

String simplePriceGbpResponseToJson(SimplePriceGbpResponse data) => json.encode(data.toJson());

class SimplePriceGbpResponse {
    SimplePriceGbpResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceGbpResponse.fromJson(Map<String, dynamic> json) => SimplePriceGbpResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.gbp,
    });

    double gbp;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        gbp: json["gbp"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "gbp": gbp,
    };
}
