// To parse this JSON data, do
//
//     final simplePriceIlsResponse = simplePriceIlsResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceIlsResponse simplePriceIlsResponseFromJson(String str) => SimplePriceIlsResponse.fromJson(json.decode(str));

String simplePriceIlsResponseToJson(SimplePriceIlsResponse data) => json.encode(data.toJson());

class SimplePriceIlsResponse {
    SimplePriceIlsResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceIlsResponse.fromJson(Map<String, dynamic> json) => SimplePriceIlsResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.ils,
    });

    double ils;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        ils: json["ils"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "ils": ils,
    };
}
