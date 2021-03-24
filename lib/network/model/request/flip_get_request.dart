// @dart=2.9
// To parse this JSON data, do
//
//     final flipGetRequest = flipGetRequestFromJson(jsonString);

import 'dart:convert';

FlipGetRequest flipGetRequestFromJson(String str) => FlipGetRequest.fromJson(json.decode(str));

String flipGetRequestToJson(FlipGetRequest data) => json.encode(data.toJson());

class FlipGetRequest {
    FlipGetRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<String> params;
    int id;
    String key;

    static const String METHOD_NAME = "flip_get";
    static const String METHOD_NAME_RAW = "flip_getRaw";

    factory FlipGetRequest.fromJson(Map<String, dynamic> json) => FlipGetRequest(
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
