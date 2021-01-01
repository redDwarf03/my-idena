// To parse this JSON data, do
//
//     final simplePriceVesResponse = simplePriceVesResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceVesResponse simplePriceVesResponseFromJson(String str) => SimplePriceVesResponse.fromJson(json.decode(str));

String simplePriceVesResponseToJson(SimplePriceVesResponse data) => json.encode(data.toJson());

class SimplePriceVesResponse {
    SimplePriceVesResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceVesResponse.fromJson(Map<String, dynamic> json) => SimplePriceVesResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.ves,
    });

    double ves;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        ves: json["ves"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "ves": ves,
    };
}
