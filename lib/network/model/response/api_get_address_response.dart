// To parse this JSON data, do
//
//     final apiGetAddressResponse = apiGetAddressResponseFromJson(jsonString);

import 'dart:convert';

ApiGetAddressResponse apiGetAddressResponseFromJson(String str) =>
    ApiGetAddressResponse.fromJson(json.decode(str));

String apiGetAddressResponseToJson(ApiGetAddressResponse data) =>
    json.encode(data.toJson());

class ApiGetAddressResponse {
  ApiGetAddressResponse({
    this.result,
    this.error,
  });

  ApiGetAddressResponseResult result;
  ApiGetAddressResponseError error;

  factory ApiGetAddressResponse.fromJson(Map<String, dynamic> json) =>
      ApiGetAddressResponse(
        result: json["result"] == null
            ? null
            : ApiGetAddressResponseResult.fromJson(json["result"]),
        error: json["error"] == null
            ? null
            : ApiGetAddressResponseError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
         "error": error.toJson(),
      };
}

class ApiGetAddressResponseResult {
  ApiGetAddressResponseResult({
    this.address,
    this.balance,
    this.stake,
    this.txCount,
    this.flipsCount,
    this.reportedFlipsCount,
  });

  String address;
  String balance;
  String stake;
  int txCount;
  int flipsCount;
  int reportedFlipsCount;

  factory ApiGetAddressResponseResult.fromJson(Map<String, dynamic> json) =>
      ApiGetAddressResponseResult(
        address: json["address"],
        balance: json["balance"],
        stake: json["stake"],
        txCount: json["txCount"],
        flipsCount: json["flipsCount"],
        reportedFlipsCount: json["reportedFlipsCount"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "balance": balance,
        "stake": stake,
        "txCount": txCount,
        "flipsCount": flipsCount,
        "reportedFlipsCount": reportedFlipsCount,
      };
}

class ApiGetAddressResponseError {
  ApiGetAddressResponseError({
    this.message,
  });

  String message;

  factory ApiGetAddressResponseError.fromJson(Map<String, dynamic> json) =>
      ApiGetAddressResponseError(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
