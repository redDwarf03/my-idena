// To parse this JSON data, do
//
//     final simplePriceKwdResponse = simplePriceKwdResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceKwdResponse simplePriceKwdResponseFromJson(String str) => SimplePriceKwdResponse.fromJson(json.decode(str));

String simplePriceKwdResponseToJson(SimplePriceKwdResponse data) => json.encode(data.toJson());

class SimplePriceKwdResponse {
    SimplePriceKwdResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceKwdResponse.fromJson(Map<String, dynamic> json) => SimplePriceKwdResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.kwd,
    });

    double kwd;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        kwd: json["kwd"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "kwd": kwd,
    };
}
