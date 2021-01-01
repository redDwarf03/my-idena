// To parse this JSON data, do
//
//     final tokensBalanceGetResponse = tokensBalanceGetResponseFromJson(jsonString);

import 'dart:convert';

List<List<dynamic>> tokensBalanceGetResponseFromJson(String str) => List<List<dynamic>>.from(json.decode(str).map((x) => List<dynamic>.from(x.map((x) => x))));

String tokensBalanceGetResponseToJson(List<List<dynamic>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x)))));
