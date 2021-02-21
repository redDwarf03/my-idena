// To parse this JSON data, do
//
//     final simplePriceZarResponse = simplePriceZarResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceZarResponse simplePriceZarResponseFromJson(String str) => SimplePriceZarResponse.fromJson(json.decode(str));

String simplePriceZarResponseToJson(SimplePriceZarResponse data) => json.encode(data.toJson());

class SimplePriceZarResponse {
    SimplePriceZarResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceZarResponse.fromJson(Map<String, dynamic> json) => SimplePriceZarResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.zar,
    });

    double zar;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        zar: json["zar"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "zar": zar,
    };
}
