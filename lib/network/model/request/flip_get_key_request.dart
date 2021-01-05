// To parse this JSON data, do
//
//     final flipGetKeyRequest = flipGetKeyRequestFromJson(jsonString);

import 'dart:convert';

FlipGetKeyRequest flipGetKeyRequestFromJson(String str) =>
    FlipGetKeyRequest.fromJson(json.decode(str));

String flipGetKeyRequestToJson(FlipGetKeyRequest data) =>
    json.encode(data.toJson());

class FlipGetKeyRequest {
  FlipGetKeyRequest({
    this.method,
    this.params,
    this.id,
    this.key,
  });

  String method;
  List<String> params;
  int id;
  String key;

  static const String METHOD_NAME = "flip_getKeys";

  factory FlipGetKeyRequest.fromJson(Map<String, dynamic> json) =>
      FlipGetKeyRequest(
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
