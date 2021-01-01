// To parse this JSON data, do
//
//     final simplePriceNzdResponse = simplePriceNzdResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceNzdResponse simplePriceNzdResponseFromJson(String str) => SimplePriceNzdResponse.fromJson(json.decode(str));

String simplePriceNzdResponseToJson(SimplePriceNzdResponse data) => json.encode(data.toJson());

class SimplePriceNzdResponse {
    SimplePriceNzdResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceNzdResponse.fromJson(Map<String, dynamic> json) => SimplePriceNzdResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.nzd,
    });

    double nzd;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        nzd: json["nzd"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "nzd": nzd,
    };
}
