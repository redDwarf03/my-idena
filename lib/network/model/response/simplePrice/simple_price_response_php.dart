// To parse this JSON data, do
//
//     final simplePricePhpResponse = simplePricePhpResponseFromJson(jsonString);

import 'dart:convert';

SimplePricePhpResponse simplePricePhpResponseFromJson(String str) => SimplePricePhpResponse.fromJson(json.decode(str));

String simplePricePhpResponseToJson(SimplePricePhpResponse data) => json.encode(data.toJson());

class SimplePricePhpResponse {
    SimplePricePhpResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePricePhpResponse.fromJson(Map<String, dynamic> json) => SimplePricePhpResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.php,
    });

    double php;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        php: json["php"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "php": php,
    };
}
