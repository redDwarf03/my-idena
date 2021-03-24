
// @dart=2.9
// To parse this JSON data, do
//
//     final contractReadonlyCallRequest = contractReadonlyCallRequestFromJson(jsonString);

import 'dart:convert';

ContractReadonlyCallRequest contractReadonlyCallRequestFromJson(String str) => ContractReadonlyCallRequest.fromJson(json.decode(str));

String contractReadonlyCallRequestToJson(ContractReadonlyCallRequest data) => json.encode(data.toJson());

class ContractReadonlyCallRequest {
    ContractReadonlyCallRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<Param> params;
    int id;
    String key;

    static const METHOD_NAME = "contract_readonlyCall";

    factory ContractReadonlyCallRequest.fromJson(Map<String, dynamic> json) => ContractReadonlyCallRequest(
        method: json["method"],
        params: List<Param>.from(json["params"].map((x) => Param.fromJson(x))),
        id: json["id"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "method": method,
        "params": List<dynamic>.from(params.map((x) => x.toJson())),
        "id": id,
        "key": key,
    };
}

class Param {
    Param({
        this.contract,
        this.method,
        this.format,
        this.args,
    });

    String contract;
    String method;
    String format;
    Args args;

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        contract: json["contract"],
        method: json["method"],
        format: json["format"],
        args: Args.fromJson(json["args"]),
    );

    Map<String, dynamic> toJson() => {
        "contract": contract,
        "method": method,
        "format": format,
        "args": args.toJson(),
    };
}

class Args {
    Args({
        this.index,
        this.format,
        this.value,
    });

    int index;
    String format;
    String value;

    factory Args.fromJson(Map<String, dynamic> json) => Args(
        index: json["index"],
        format: json["format"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "format": format,
        "value": value,
    };
}
