// To parse this JSON data, do
//
//     final simplePriceKrwResponse = simplePriceKrwResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceKrwResponse simplePriceKrwResponseFromJson(String str) => SimplePriceKrwResponse.fromJson(json.decode(str));

String simplePriceKrwResponseToJson(SimplePriceKrwResponse data) => json.encode(data.toJson());

class SimplePriceKrwResponse {
    SimplePriceKrwResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceKrwResponse.fromJson(Map<String, dynamic> json) => SimplePriceKrwResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.krw,
    });

    double krw;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        krw: json["krw"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "krw": krw,
    };
}
