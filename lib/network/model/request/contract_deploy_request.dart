// To parse this JSON data, do
//
//     final contractDeployRequest = contractDeployRequestFromJson(jsonString);

import 'dart:convert';

ContractDeployRequest contractDeployRequestFromJson(String str) => ContractDeployRequest.fromJson(json.decode(str));

String contractDeployRequestToJson(ContractDeployRequest data) => json.encode(data.toJson());

class ContractDeployRequest {
    ContractDeployRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<Param> params;
    int id;
    String key;

    static const METHOD_NAME = "contract_deploy";

    factory ContractDeployRequest.fromJson(Map<String, dynamic> json) => ContractDeployRequest(
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
        this.from,
        this.codeHash,
        this.amount,
        this.args,
        this.maxFee,
    });

    String from;
    String codeHash;
    int amount;
    Args args;
    int maxFee;

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        from: json["from"],
        codeHash: json["codeHash"],
        amount: json["amount"],
        args: Args.fromJson(json["args"]),
        maxFee: json["maxFee"],
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "codeHash": codeHash,
        "amount": amount,
        "args": args.toJson(),
        "maxFee": maxFee,
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
        index: json[" index "],
        format: json[" format "],
        value: json[" value "],
    );

    Map<String, dynamic> toJson() => {
        " index ": index,
        " format ": format,
        " value ": value,
    };
}