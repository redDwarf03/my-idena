import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// Instance of PBKDF2 derive a key from password, salt, and hash function.
///
/// https://en.wikipedia.org/wiki/PBKDF2
class PBKDF2 {
  Hash _hashAlgorithm = sha256;
  int _blockSize;

  /// Creates instance capable of generating a key.
  ///
  /// [hashAlgorithm] defaults to [sha256].
  PBKDF2([Hash hashAlgorithm]) {
    _hashAlgorithm = hashAlgorithm;
    _blockSize = _hashAlgorithm.convert([1, 2, 3]).bytes.length;
  }

  /// Hashes a [password] with a given [salt].
  ///
  /// The length of this return value will be [keyLength].
  Uint8List generateKey(
      String password, Uint8List salt, int rounds, int keyLength) {
    _validateKeyLength(keyLength);

    int numberOfBlocks = (keyLength / _blockSize).ceil();
    Hmac hmac = new Hmac(_hashAlgorithm, utf8.encode(password));
    ByteData key = new ByteData(keyLength);
    int offset = 0;

    int saltLength = salt.length;
    ByteData inputBuffer = new ByteData(salt.length + 4)
      ..buffer.asUint8List().setRange(0, salt.length, salt);

    for (int blockNumber = 1; blockNumber <= numberOfBlocks; blockNumber++) {
      inputBuffer.setUint8(saltLength, blockNumber >> 24);
      inputBuffer.setUint8(saltLength + 1, blockNumber >> 16);
      inputBuffer.setUint8(saltLength + 2, blockNumber >> 8);
      inputBuffer.setUint8(saltLength + 3, blockNumber);

      Uint8List block = _XORDigestSink.generate(inputBuffer, hmac, rounds);
      int blockLength = _blockSize;
      if (offset + blockLength > keyLength) {
        blockLength = keyLength - offset;
      }
      key.buffer.asUint8List().setRange(offset, offset + blockLength, block);

      offset += blockLength;
    }
    return key.buffer.asUint8List();
  }

  void _validateKeyLength(int keyLength) {
    if (keyLength > (pow(2, 32) - 1) * _blockSize) {
      throw new Exception('PBKDF2: Derived key is too long');
    }
  }
}

class _XORDigestSink extends Sink<Digest> {
  _XORDigestSink(ByteData inputBuffer, Hmac hmac) {
    lastDigest = hmac.convert(inputBuffer.buffer.asUint8List()).bytes;
    bytes = new ByteData(lastDigest.length)
      ..buffer.asUint8List().setRange(0, lastDigest.length, lastDigest);
  }

  static Uint8List generate(ByteData inputBuffer, Hmac hmac, int rounds) {
    _XORDigestSink hashSink = new _XORDigestSink(inputBuffer, hmac);

    // If rounds == 1, we have already run the first hash in the constructor
    // so this loop won't run.
    for (int round = 1; round < rounds; round++) {
      ByteConversionSink hmacSink = hmac.startChunkedConversion(hashSink);
      hmacSink.add(hashSink.lastDigest);
      hmacSink.close();
    }

    return hashSink.bytes.buffer.asUint8List();
  }

  ByteData bytes;
  Uint8List lastDigest;

  @override
  void add(Digest digest) {
    lastDigest = digest.bytes;
    for (int i = 0; i < digest.bytes.length; i++) {
      bytes.setUint8(i, bytes.getUint8(i) ^ lastDigest[i]);
    }
  }

  @override
  void close() {}
}