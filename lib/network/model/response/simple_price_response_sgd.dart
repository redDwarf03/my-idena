// To parse this JSON data, do
//
//     final simplePriceSgdResponse = simplePriceSgdResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceSgdResponse simplePriceSgdResponseFromJson(String str) => SimplePriceSgdResponse.fromJson(json.decode(str));

String simplePriceSgdResponseToJson(SimplePriceSgdResponse data) => json.encode(data.toJson());

class SimplePriceSgdResponse {
    SimplePriceSgdResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceSgdResponse.fromJson(Map<String, dynamic> json) => SimplePriceSgdResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.sgd,
    });

    double sgd;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        sgd: json["sgd"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "sgd": sgd,
    };
}
