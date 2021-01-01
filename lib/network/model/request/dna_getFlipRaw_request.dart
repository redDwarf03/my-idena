// To parse this JSON data, do
//
//     final getFlipRawRequest = getFlipRawRequestFromJson(jsonString);

import 'dart:convert';

GetFlipRawRequest getFlipRawRequestFromJson(String str) => GetFlipRawRequest.fromJson(json.decode(str));

String getFlipRawRequestToJson(GetFlipRawRequest data) => json.encode(data.toJson());

class GetFlipRawRequest {
    GetFlipRawRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<String> params;
    int id;
    String key;

    static const String METHOD_NAME = "flip_getRaw";

    factory GetFlipRawRequest.fromJson(Map<String, dynamic> json) => GetFlipRawRequest(
        method: json["method"],
        params: List<String>.from(json["params"].map((x) => x)),
        id: json["id"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "params": List<dynamic>.from(params.map((x) => x)),
        "id": id,
        "key": key,
    };
}







