import 'dart:convert';

AuthenticateResponse authenticateResponseFromJson(String str) => AuthenticateResponse.fromJson(json.decode(str));

String authenticateResponseToJson(AuthenticateResponse data) => json.encode(data.toJson());

class AuthenticateResponse {
    AuthenticateResponse({
        this.data,
    });

    Data? data;

    factory AuthenticateResponse.fromJson(Map<String, dynamic> json) => AuthenticateResponse(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.authenticated,
    });

    bool? authenticated;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        authenticated: json["authenticated"],
    );

    Map<String, dynamic> toJson() => {
        "authenticated": authenticated,
    };
}
