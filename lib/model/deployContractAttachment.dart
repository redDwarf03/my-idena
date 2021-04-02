// @dart=2.9
// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:typed_data' show Uint8List;
import 'package:my_idena/protos/models.pb.dart' show ProtoDeployContractAttachment;

class DeployContractAttachment {
  DeployContractAttachment(codeHash, args) {
    this.codeHash = codeHash;
    this.args = args;
  }

  var codeHash;
  var args;

  Uint8List toBytes() {
    ProtoDeployContractAttachment data = new ProtoDeployContractAttachment();
    data.codeHash = new Uint8List(this.codeHash);
    for (int i = 0; i < this.args.length; i += 1) {
      data.args.add(new Uint8List(this.args[i]));
    }
    return data.writeToBuffer();
  }

  DeployContractAttachment fromBytes(bytes) {
    ProtoDeployContractAttachment protoAttachment = ProtoDeployContractAttachment.fromBuffer(bytes);
    this.codeHash = protoAttachment.codeHash;
    this.args = protoAttachment.args;
    return this;
  }

}
