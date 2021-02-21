// To parse this JSON data, do
//
//     final simplePriceAudResponse = simplePriceAudResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceAudResponse simplePriceAudResponseFromJson(String str) => SimplePriceAudResponse.fromJson(json.decode(str));

String simplePriceaudResponseToJson(SimplePriceAudResponse data) => json.encode(data.toJson());

class SimplePriceAudResponse {
    SimplePriceAudResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceAudResponse.fromJson(Map<String, dynamic> json) => SimplePriceAudResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.aud,
    });

    double aud;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        aud: json["aud"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "aud": aud,
    };
}
