import 'dart:convert';

NonceEndpointResponse nonceEndpointResponseFromJson(String str) =>
    NonceEndpointResponse.fromJson(json.decode(str));

String nonceEndpointResponseToJson(NonceEndpointResponse data) =>
    json.encode(data.toJson());

class NonceEndpointResponse {
  NonceEndpointResponse({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory NonceEndpointResponse.fromJson(Map<String, dynamic> json) =>
      NonceEndpointResponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.nonce,
  });

  String? nonce;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        nonce: json["nonce"],
      );

  Map<String, dynamic> toJson() => {
        "nonce": nonce,
      };
}
