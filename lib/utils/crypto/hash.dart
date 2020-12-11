import 'dart:typed_data';

import 'package:my_idena/utils/crypto/utils_crypto.dart';
import 'package:pointycastle/pointycastle.dart';

///
/// Creates Keccak hash of the input
///
Uint8List keccak(dynamic a, {int bits: 256}) {
  a = toBuffer(a);
  Digest sha3 = new Digest("SHA-3/${bits}");
  return sha3.process(a);
}

///
/// Creates Keccak-256 hash of the input, alias for keccak(a, 256).
///
Uint8List keccak256(dynamic a) {
  return keccak(a);
}
