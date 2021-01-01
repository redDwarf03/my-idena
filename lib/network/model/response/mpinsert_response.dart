// To parse this JSON data, do
//
//     final mpinsertResponse = mpinsertResponseFromJson(jsonString);

import 'dart:convert';

List<String> mpinsertResponseFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String mpinsertResponseToJson(List<String> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
