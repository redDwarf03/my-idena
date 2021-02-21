// To parse this JSON data, do
//
//     final simplePriceUsdResponse = simplePriceUsdResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceUsdResponse simplePriceUsdResponseFromJson(String str) => SimplePriceUsdResponse.fromJson(json.decode(str));

String simplePriceUsdResponseToJson(SimplePriceUsdResponse data) => json.encode(data.toJson());

class SimplePriceUsdResponse {
    SimplePriceUsdResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceUsdResponse.fromJson(Map<String, dynamic> json) => SimplePriceUsdResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.usd,
    });

    double usd;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        usd: json["usd"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "usd": usd,
    };
}
