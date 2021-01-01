// To parse this JSON data, do
//
//     final simplePriceBtcResponse = simplePriceBtcResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceBtcResponse simplePriceBtcResponseFromJson(String str) => SimplePriceBtcResponse.fromJson(json.decode(str));

String simplePriceBtcResponseToJson(SimplePriceBtcResponse data) => json.encode(data.toJson());

class SimplePriceBtcResponse {
    SimplePriceBtcResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceBtcResponse.fromJson(Map<String, dynamic> json) => SimplePriceBtcResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.btc,
    });

    double btc;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        btc: json["btc"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "btc": btc,
    };
}
