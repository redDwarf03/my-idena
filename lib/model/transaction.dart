// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';

import 'package:ethereum_util/ethereum_util.dart';
import 'package:hex/hex.dart';
import 'package:my_idena/protos/models.pb.dart';

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  Transaction({
    this.nonce,
    this.epoch,
    this.type,
    this.to,
    this.amount,
    this.maxFee,
    this.tips,
    this.payload,
    this.signature,
  });

  int nonce;
  int epoch;
  int type;
  String to;
  BigInt amount;
  BigInt maxFee;
  BigInt tips;
  Uint8List payload;
  String signature;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        nonce: json["nonce"],
        epoch: json["epoch"],
        type: json["type"],
        to: json["to"],
        amount: json["amount"],
        maxFee: json["maxFee"],
        tips: json["tips"],
        payload: json["payload"],
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "nonce": nonce,
        "epoch": epoch,
        "type": type,
        "to": to,
        "amount": amount,
        "maxFee": maxFee,
        "tips": tips,
        "payload": payload,
        "signature": signature,
      };

  fromHex(List<int> hex) {
    return this.fromBytes(hex);
  }

  Transaction fromBytes(bytes) {
    ProtoTransaction protoTx = ProtoTransaction.fromBuffer(bytes);
    ProtoTransaction_Data protoTxData = protoTx.data;
    this.nonce = protoTxData.nonce;
    this.epoch = protoTxData.epoch;
    this.type = protoTxData.type;
    this.to = toHexString(protoTxData.to, true);

    this.amount =
        decodeBigInt(toBuffer(Uint8List.fromList(protoTxData.amount)));
    this.maxFee =
        decodeBigInt(toBuffer(Uint8List.fromList(protoTxData.maxFee)));
    this.tips = decodeBigInt(toBuffer(Uint8List.fromList(protoTxData.tips)));
    this.payload = protoTxData.payload;
    this.signature = HEX.encode(protoTx.signature);

    return this;
  }

  String toHex() {
    return HEX.encode(this.toBytes());
  }

  Uint8List toBytes() {
    ProtoTransaction transaction = new ProtoTransaction();
    transaction.data = this._createProtoTxData();
    if (this.signature != null) {
      transaction.signature = toBuffer(this.signature);
    }
    return transaction.writeToBuffer();
  }

  ProtoTransaction_Data _createProtoTxData() {
    ProtoTransaction_Data data = new ProtoTransaction_Data();
    data.nonce = this.nonce;
    data.epoch = this.epoch;
    data.type = this.type;
    if (this.to != null) {
      data.to = toBuffer(this.to);
    }
    if (this.amount != null) {
      data.amount = toBuffer(this.amount);
    }
    if (this.maxFee != null) {
      data.maxFee = toBuffer(this.maxFee);
    }
    if (this.amount != null) {
      data.tips = toBuffer(this.tips);
    }
    if (this.payload != null) {
      data.payload = toBuffer(this.payload);
    }

    return data;
  }

  String toHexString(byteArray, bool withPrefix) {
    return ((withPrefix ? '0x' : '') + HEX.encode(toBuffer(byteArray)));
  }

  String signTx(String privateKey) {
    return "";
  }

}
