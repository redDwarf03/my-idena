import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

class AesGcm {
  Uint8List _key32;

  AesGcm(this._key32);

  String encrypt(String input, [Uint8List iv]) {
    CipherParameters params = PaddedBlockCipherParameters(
        ParametersWithIV<KeyParameter>(KeyParameter(_key32), iv), null);
    PaddedBlockCipher cipher = PaddedBlockCipher('AES/GCM/PKCS7');
    cipher..init(true, params);
    Uint8List inter = cipher.process(utf8.encode(input) as Uint8List);
    return base64.encode(inter);
  }

  String decrypt(String encrypted, [Uint8List iv]) {
    CipherParameters params = PaddedBlockCipherParameters(
        ParametersWithIV(KeyParameter(_key32), iv), null);
    PaddedBlockCipher cipher = PaddedBlockCipher('AES/GCM/PKCS7');
    cipher..init(false, params);
    Uint8List inter = cipher.process(base64.decode(encrypted));
    return utf8.decode(inter);
  }
}