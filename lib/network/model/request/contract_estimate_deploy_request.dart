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
    List<Params> params;
    int id;
    String key;

    static const METHOD_NAME = "contract_estimateDeploy";

    factory ContractEstimateDeployRequest.fromJson(Map<String, dynamic> json) => ContractEstimateDeployRequest(
        method: json[" method "],
        params: List<Params>.from(json[" params "].map((x) => Params.fromJson(x))),
        id: json[" id "],
        key: json[" key "],
    );

    Map<String, dynamic> toJson() => {
        " method ": method,
        " params ": List<dynamic>.from(params.map((x) => x.toJson())),
        " id ": id,
        " key ": key,
    };
}

class Params {
    Params({
        this.from,
        this.codeHash,
        this.amount,
        this.maxFee,
        this.args,
    });

    String from;
    String codeHash;
    int amount;
    int maxFee;
    List<Args> args;

    factory Params.fromJson(Map<String, dynamic> json) => Params(
        from: json[" from "],
        codeHash: json[" codeHash "],
        amount: json[" amount "],
        maxFee: json[" maxFee "],
        args: List<Args>.from(json[" args "].map((x) => Args.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        " from ": from,
        " codeHash ": codeHash,
        " amount ": amount,
        " maxFee ": maxFee,
        " args ": List<dynamic>.from(args.map((x) => x.toJson())),
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
