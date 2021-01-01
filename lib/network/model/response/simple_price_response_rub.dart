// To parse this JSON data, do
//
//     final simplePriceRubResponse = simplePriceRubResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceRubResponse simplePriceRubResponseFromJson(String str) => SimplePriceRubResponse.fromJson(json.decode(str));

String simplePriceRubResponseToJson(SimplePriceRubResponse data) => json.encode(data.toJson());

class SimplePriceRubResponse {
    SimplePriceRubResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceRubResponse.fromJson(Map<String, dynamic> json) => SimplePriceRubResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.rub,
    });

    double rub;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        rub: json["rub"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "rub": rub,
    };
}
