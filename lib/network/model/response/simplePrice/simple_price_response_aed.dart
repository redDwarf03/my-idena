// To parse this JSON data, do
//
//     final simplePriceAedResponse = simplePriceAedResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceAedResponse simplePriceAedResponseFromJson(String str) => SimplePriceAedResponse.fromJson(json.decode(str));

String simplePriceAedResponseToJson(SimplePriceAedResponse data) => json.encode(data.toJson());

class SimplePriceAedResponse {
    SimplePriceAedResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceAedResponse.fromJson(Map<String, dynamic> json) => SimplePriceAedResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.aed,
    });

    double aed;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        aed: json["aed"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "aed": aed,
    };
}
