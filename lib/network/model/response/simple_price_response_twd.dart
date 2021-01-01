// To parse this JSON data, do
//
//     final simplePriceTwdResponse = simplePriceTwdResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceTwdResponse simplePriceTwdResponseFromJson(String str) => SimplePriceTwdResponse.fromJson(json.decode(str));

String simplePriceTwdResponseToJson(SimplePriceTwdResponse data) => json.encode(data.toJson());

class SimplePriceTwdResponse {
    SimplePriceTwdResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceTwdResponse.fromJson(Map<String, dynamic> json) => SimplePriceTwdResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.twd,
    });

    double twd;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        twd: json["twd"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "twd": twd,
    };
}
