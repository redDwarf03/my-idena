// To parse this JSON data, do
//
//     final simplePriceHufResponse = simplePriceHufResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceHufResponse simplePriceHufResponseFromJson(String str) => SimplePriceHufResponse.fromJson(json.decode(str));

String simplePriceHufResponseToJson(SimplePriceHufResponse data) => json.encode(data.toJson());

class SimplePriceHufResponse {
    SimplePriceHufResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceHufResponse.fromJson(Map<String, dynamic> json) => SimplePriceHufResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.huf,
    });

    double huf;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        huf: json["huf"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "huf": huf,
    };
}
