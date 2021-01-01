// To parse this JSON data, do
//
//     final sendTxRequest = sendTxRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart' as asn1lib;
import 'package:pointycastle/pointycastle.dart';

class SendTxRequest {
  SendTxRequest({
    this.id,
    this.tx,
    this.buffer,
    this.signature,
    this.publicKey,
    this.websocketCommand,
  });

  int id;
  Tx tx;
  String buffer;
  String signature;
  String publicKey;
  String websocketCommand;

  String signString(String privateKey, String msgToSign) {

    var sig64 = "";

    //print("return sig64 : " + sig64);
    return sig64;
  
  }

  void buildSignature(String privateKey) async {
    signature = signString(privateKey, buffer);
    //print("signature: " + signature);
  }

  factory SendTxRequest.fromJson(Map<String, dynamic> json) => SendTxRequest(
        id: json["id"],
        tx: Tx.fromJson(json["tx"]),
        buffer: json["buffer"],
        signature: json["signature"],
        publicKey: json["public_key"],
        websocketCommand: json["websocket_command"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tx": tx.toJson(),
        "buffer": buffer,
        "signature": signature,
        "public_key": publicKey,
        "websocket_command": websocketCommand,
      };

  String buildCommand() {
    String command = '["' + tx.timestamp + '",';
    command += '"' + tx.address + '", ';
    command += '"' + tx.recipient + '", ';
    command += '"' + tx.amount + '", ';
    command += '"' + signature + '", ';
    command += '"' + publicKey + '", ';
    command += '"' + tx.operation + '", ';
    command += '"' + tx.openfield.replaceAll('"', '\\"') + '"]';
    //print("command : " + command);
    return command;
  }
}

class Tx {
  Tx({
    this.timestamp,
    this.address,
    this.recipient,
    this.amount,
    this.operation,
    this.openfield,
  });

  String timestamp;
  String address;
  String recipient;
  String amount;
  String operation;
  String openfield;

  factory Tx.fromJson(Map<String, dynamic> json) => Tx(
        timestamp: json["timestamp"],
        address: json["address"],
        recipient: json["recipient"],
        amount: json["amount"],
        operation: json["operation"],
        openfield: json["openfield"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "address": address,
        "recipient": recipient,
        "amount": amount,
        "operation": operation,
        "openfield": openfield,
      };

  String buildBufferValue() {
    String _buffer = "('" +
        timestamp +
        "', '" +
        address +
        "', '" +
        recipient +
        "', '" +
        amount +
        "', '" +
        operation +
        "', '" +
        openfield +
        "')";
    //print("_buffer : " + _buffer);
    return _buffer;
  }
}

