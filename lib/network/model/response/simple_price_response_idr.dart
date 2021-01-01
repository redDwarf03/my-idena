// To parse this JSON data, do
//
//     final simplePriceIdrResponse = simplePriceIdrResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceIdrResponse simplePriceIdrResponseFromJson(String str) => SimplePriceIdrResponse.fromJson(json.decode(str));

String simplePriceIdrResponseToJson(SimplePriceIdrResponse data) => json.encode(data.toJson());

class SimplePriceIdrResponse {
    SimplePriceIdrResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceIdrResponse.fromJson(Map<String, dynamic> json) => SimplePriceIdrResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.idr,
    });

    double idr;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        idr: json["idr"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "idr": idr,
    };
}
