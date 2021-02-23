import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:ethereum_util/ethereum_util.dart' as ethereum_util;
import 'package:hex/hex.dart';
import 'package:my_idena/util/app_ffi/encrypt/encrypted.dart';
import 'package:my_idena/util/crypto/utils_crypto.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:web3dart/crypto.dart' as crypto;
import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart' as pc;

String decryptMessage(String key, String data) {

  key = remove0x(key);
  data = remove0x(data);
  
  var ephemKeyLength = 65;
  var ivLength = 16;
  var macLength = 32;
  var encrypted = crypto.hexToBytes(data);
  int metaLength = ephemKeyLength + ivLength + macLength;

  if (encrypted.length < metaLength) {
    print('Invalid Ciphertext. Data is too small');
    return null;
  }

  // deserialise
  var ephemPublicKey = encrypted.sublist(0, ephemKeyLength);
  var cipherTextLength = encrypted.length - metaLength;
  var iv = encrypted.sublist(ephemKeyLength, ephemKeyLength + ivLength);
  var cipherAndIv = encrypted.sublist(
      ephemKeyLength, ephemKeyLength + ivLength + cipherTextLength);
  var ciphertext = cipherAndIv.sublist(ivLength);
  var msgMac = encrypted.sublist(ephemKeyLength + ivLength + cipherTextLength);

  // derive private key
  ECDomainParameters curve = ECDomainParameters('secp256k1');
  ECPoint s = curve.curve.decodePoint(ephemPublicKey);
  var px = (s * BigInt.parse(key, radix: 16)).x.toBigInteger();
  var hash = _kdf(px, 32);

  var encryptionKey = Uint8List.fromList(hash.sublist(0, 16));
  var macKey = sha256.convert(Uint8List.fromList(hash.sublist(16))).bytes;

  // check HMAC
  var currentHMAC = new Hmac(sha256, macKey);
  var digest = currentHMAC.convert(cipherAndIv);

  // decrypt message - ok
  final encryptedText = Encrypted.fromBase16(hex.encode(ciphertext));
  final ctr = pc.CTRStreamCipher(pc.AESFastEngine())
    ..init(false, pc.ParametersWithIV(pc.KeyParameter(encryptionKey), iv));
  Uint8List decrypted = ctr.process(encryptedText.bytes);
  //print(HEX.encode(decrypted));

  return(HEX.encode(decrypted));
}

Uint8List _kdf(secret, outputLength) {
  var ctr = 1;
  var written = 0;
  List result = new List<int>();
  while (written < outputLength) {
    var ctrs = Uint8List.fromList([ctr >> 24, ctr >> 16, ctr >> 8, ctr]);
    Uint8List hashResult = ethereum_util.sha256(ctrs + _bigIntToBytes(secret));
    result.addAll(hashResult);
    written += 32;
    ctr += 1;
  }
  return Uint8List.fromList(result);
}

/// Converts a hex string to a Uint8List
Uint8List _hexToBytes(String hex) {
  return Uint8List.fromList(HEX.decode(hex));
}

/// Convert a bigint to a byte array
Uint8List _bigIntToBytes(BigInt bigInt) {
  return _hexToBytes(bigInt.toRadixString(16).padLeft(32, "0"));
}


