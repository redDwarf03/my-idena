// To parse this JSON data, do
//
//     final simplePriceMxnResponse = simplePriceMxnResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceMxnResponse simplePriceMxnResponseFromJson(String str) => SimplePriceMxnResponse.fromJson(json.decode(str));

String simplePriceMxnResponseToJson(SimplePriceMxnResponse data) => json.encode(data.toJson());

class SimplePriceMxnResponse {
    SimplePriceMxnResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceMxnResponse.fromJson(Map<String, dynamic> json) => SimplePriceMxnResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.mxn,
    });

    double mxn;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        mxn: json["mxn"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "mxn": mxn,
    };
}
