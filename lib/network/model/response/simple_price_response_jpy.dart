// To parse this JSON data, do
//
//     final simplePriceJpyResponse = simplePriceJpyResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceJpyResponse simplePriceJpyResponseFromJson(String str) => SimplePriceJpyResponse.fromJson(json.decode(str));

String simplePriceJpyResponseToJson(SimplePriceJpyResponse data) => json.encode(data.toJson());

class SimplePriceJpyResponse {
    SimplePriceJpyResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceJpyResponse.fromJson(Map<String, dynamic> json) => SimplePriceJpyResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.jpy,
    });

    double jpy;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        jpy: json["jpy"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "jpy": jpy,
    };
}
