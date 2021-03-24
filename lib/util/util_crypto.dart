// @dart=2.9
import 'dart:convert';
import 'dart:typed_data';


import 'package:hex/hex.dart';
import 'package:my_idena/pubdev/cryptography/algorithms/aes_gcm.dart';
import 'package:my_idena/pubdev/cryptography/nonce.dart';
import 'package:my_idena/pubdev/cryptography/secret_key.dart';
import 'package:sha3/sha3.dart';
import 'package:web3dart/web3dart.dart';

class UtilCrypto {
  Future<String> encryptedPrivateKeyToAddress(
      String encPrivateKey, String password) async {
    try {
      EthPrivateKey ethPrivateKey = EthPrivateKey.fromHex(
          await encryptedPrivateKeyToSeed(encPrivateKey, password));
      final address = await ethPrivateKey.extractAddress();

      //print("address.hex : " + address.hex);
      return address.hex;
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<String> encryptedPrivateKeyToSeed(
      String encPrivateKey, String password) async {
    try {
      if (encPrivateKey == null ||
          encPrivateKey.length == 0 ||
          password == null ||
          password.length == 0) {
        return "";
      }

      var k = SHA3(256, SHA3_PADDING, 256);
      k.update(utf8.encode(password));
      final key = Uint8List.fromList(k.digest());
      //print(" hash mdp = key: " + HEX.encode(key));
      //print(key);

      var dataArray = Uint8List.fromList(HEX.decode(encPrivateKey));
      //print("** dataArrayhex : " + encPrivateKey);
      if (dataArray.length < 12) {
        return "";
      }
      final dataArray0to12 = dataArray.sublist(0, 12);
      final cypherText = dataArray.sublist(12);
      //print("cypher : " + HEX.encode(cypherText));

      final iv = dataArray0to12;
      //print("iv : " + HEX.encode(iv));
      //print("aad : " + HEX.encode(aad));
      var secretKey = new SecretKey(key);
      Nonce nonce = new Nonce(iv);

      Uint8List decrypted =
          aesGcm.decryptSync(cypherText, secretKey: secretKey, nonce: nonce);
      //print("decrypted: " + HEX.encode(decrypted));

      return HEX.encode(decrypted);
    } catch (e) {
      return "";
    }
  }

}
