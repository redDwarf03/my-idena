// To parse this JSON data, do
//
//     final contractTerminateRequest = contractTerminateRequestFromJson(jsonString);

import 'dart:convert';

ContractTerminateRequest contractTerminateRequestFromJson(String str) => ContractTerminateRequest.fromJson(json.decode(str));

String contractTerminateRequestToJson(ContractTerminateRequest data) => json.encode(data.toJson());

class ContractTerminateRequest {
    ContractTerminateRequest({
        this.method,
        this.params,
        this.id,
        this.key,
    });

    String method;
    List<Param> params;
    int id;
    String key;

    static const METHOD_NAME = "contract_terminate";

    factory ContractTerminateRequest.fromJson(Map<String, dynamic> json) => ContractTerminateRequest(
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
        this.contract,
        this.args,
        this.maxFee,
    });

    String from;
    String contract;
    List<Arg> args;
    double maxFee;

    factory Param.fromJson(Map<String, dynamic> json) => Param(
        from: json["from"],
        contract: json["contract"],
        args: List<Arg>.from(json["args"].map((x) => Arg.fromJson(x))),
        maxFee: json["maxFee"],
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "contract": contract,
        "args": List<dynamic>.from(args.map((x) => x.toJson())),
        "maxFee": maxFee,
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
