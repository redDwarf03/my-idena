// To parse this JSON data, do
//
//     final simplePriceHkdResponse = simplePriceHkdResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceHkdResponse simplePriceHkdResponseFromJson(String str) => SimplePriceHkdResponse.fromJson(json.decode(str));

String simplePriceHkdResponseToJson(SimplePriceHkdResponse data) => json.encode(data.toJson());

class SimplePriceHkdResponse {
    SimplePriceHkdResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceHkdResponse.fromJson(Map<String, dynamic> json) => SimplePriceHkdResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.hkd,
    });

    double hkd;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        hkd: json["hkd"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "hkd": hkd,
    };
}
