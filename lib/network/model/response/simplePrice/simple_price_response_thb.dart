// To parse this JSON data, do
//
//     final simplePriceThbResponse = simplePriceThbResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceThbResponse simplePriceThbResponseFromJson(String str) => SimplePriceThbResponse.fromJson(json.decode(str));

String simplePriceThbResponseToJson(SimplePriceThbResponse data) => json.encode(data.toJson());

class SimplePriceThbResponse {
    SimplePriceThbResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceThbResponse.fromJson(Map<String, dynamic> json) => SimplePriceThbResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.thb,
    });

    double thb;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        thb: json["thb"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "thb": thb,
    };
}
