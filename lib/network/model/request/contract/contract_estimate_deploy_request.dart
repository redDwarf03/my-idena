// To parse this JSON data, do
//
//     final contractEstimateDeployRequest = contractEstimateDeployRequestFromJson(jsonString);

import 'dart:convert';

ContractEstimateDeployRequest contractEstimateDeployRequestFromJson(String str) => ContractEstimateDeployRequest.fromJson(json.decode(str));

String contractEstimateDeployRequestToJson(ContractEstimateDeployRequest data) => json.encode(data.toJson());

class ContractEstimateDeployRequest {
    ContractEstimateDeployRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<Param> params;
    int id;
    String key;

    static const METHOD_NAME = "contract_estimateDeploy";

    factory ContractEstimateDeployRequest.fromJson(Map<String, dynamic> json) => ContractEstimateDeployRequest(
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
        this.maxFee,
        this.args,
    });

    String from;
    String codeHash;
    double amount;
    int maxFee;
    List<Arg> args;

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        from: json["from"],
        codeHash: json["codeHash"],
        amount: json["amount"],
        maxFee: json["maxFee"],
        args: List<Arg>.from(json["args"].map((x) => Arg.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "codeHash": codeHash,
        "amount": amount,
        "maxFee": maxFee,
        "args": List<dynamic>.from(args.map((x) => x.toJson())),
    };
}

class Arg {
    Arg({
        this.index,
        this.format,
        this.value,
    });

    int index;
    String format;
    String value;

    factory Arg.fromJson(Map<String, dynamic> json) => Arg(
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
