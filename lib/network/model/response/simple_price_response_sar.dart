// To parse this JSON data, do
//
//     final simplePriceSarResponse = simplePriceSarResponseFromJson(jsonString);

import 'dart:convert';

SimplePriceSarResponse simplePriceSarResponseFromJson(String str) => SimplePriceSarResponse.fromJson(json.decode(str));

String simplePriceSarResponseToJson(SimplePriceSarResponse data) => json.encode(data.toJson());

class SimplePriceSarResponse {
    SimplePriceSarResponse({
        this.idena,
    });

    Idena idena;

    factory SimplePriceSarResponse.fromJson(Map<String, dynamic> json) => SimplePriceSarResponse(
        idena: Idena.fromJson(json["idena"]),
    );

    Map<String, dynamic> toJson() => {
        "idena": idena.toJson(),
    };
}

class Idena {
    Idena({
        this.sar,
    });

    double sar;

    factory Idena.fromJson(Map<String, dynamic> json) => Idena(
        sar: json["sar"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "sar": sar,
    };
}
