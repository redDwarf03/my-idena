// To parse this JSON data, do
//
//     final simplePriceChfResponse = simplePriceChfResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceChfResponse simplePriceChfResponseFromJson(String str) => SimplePriceChfResponse.fromJson(json.decode(str));

String simplePriceChfResponseToJson(SimplePriceChfResponse data) => json.encode(data.toJson());

class SimplePriceChfResponse {
    SimplePriceChfResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceChfResponse.fromJson(Map<String, dynamic> json) => SimplePriceChfResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.chf,
    });

    double chf;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        chf: json["chf"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "chf": chf,
    };
}
