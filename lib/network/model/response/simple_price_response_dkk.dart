// To parse this JSON data, do
//
//     final simplePriceDkkResponse = simplePriceDkkResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceDkkResponse simplePriceDkkResponseFromJson(String str) => SimplePriceDkkResponse.fromJson(json.decode(str));

String simplePriceDkkResponseToJson(SimplePriceDkkResponse data) => json.encode(data.toJson());

class SimplePriceDkkResponse {
    SimplePriceDkkResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceDkkResponse.fromJson(Map<String, dynamic> json) => SimplePriceDkkResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.dkk,
    });

    double dkk;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        dkk: json["dkk"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "dkk": dkk,
    };
}
