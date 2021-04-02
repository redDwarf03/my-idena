// @dart=2.9
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hex/hex.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/db/account.dart' as Account;
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/model/vault.dart';
import 'package:my_idena/network/model/response/dna_getCoinbaseAddr_response.dart';
import 'package:my_idena/factory/app_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/util/app_ffi/keys/mnemonics.dart';
import 'package:my_idena/util/enums/wallet_type.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:my_idena/util/util_crypto.dart';
import 'package:my_idena/util/util_demo_mode.dart';
import 'package:my_idena/util/util_node.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:sha3/sha3.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class AppUtil {
  Future<String> getAddress() async {
    //String address = await sl.get<SharedPrefsUtil>().getAddress();
    String address = "";
    //if (address == "") {
      if (await NodeUtil().getNodeType() == PUBLIC_NODE) {
        address = PN_ADDRESS;
      } else if (await NodeUtil().getNodeType() == DEMO_NODE) {
        address = DM_IDENTITY_ADDRESS;
      } else {
        if (await NodeUtil().getNodeType() != SHARED_NODE) {
          DnaGetCoinbaseAddrResponse dnaGetCoinbaseAddrResponse =
              await sl.get<AppService>().getDnaGetCoinbaseAddr();
          address = dnaGetCoinbaseAddrResponse == null
              ? ""
              : dnaGetCoinbaseAddrResponse.result;
        } else {
          await UtilCrypto()
              .encryptedPrivateKeyToAddress(
                  await sl.get<SharedPrefsUtil>().getEncryptedPk(),
                  await sl.get<SharedPrefsUtil>().getPasswordPk())
              .then((value) async {
            if (value != "") {
              address = value;
              //print("address: " + address);
              await UtilCrypto()
                  .encryptedPrivateKeyToSeed(
                      await sl.get<SharedPrefsUtil>().getEncryptedPk(),
                      await sl.get<SharedPrefsUtil>().getPasswordPk())
                  .then((value) => sl.get<Vault>().setSeed(value));
            }
          });
        }
      }
    //}

    //print("address : " + address);
    return address;
  }

  Future<String> seedToAddress(
      String seed, int index, String seedOrigin) async {
    String mnemonic = bip39.entropyToMnemonic(seed);
    //print('mnemonic: ' + mnemonic);

    EthPrivateKey ethPrivateKey;
    //print(seedOrigin);

    if (seedOrigin == null || seedOrigin == HD_WALLET) {
      ethPrivateKey =
          EthPrivateKey.fromHex(await seedToPrivateKey(seed, index));
    } else {
      ethPrivateKey = EthPrivateKey.fromHex(
          AppMnemomics.mnemonicListToSeed(mnemonic.split(' ')));
    }

    //address = await ethPrivateKey.extractAddress();

    var k = SHA3(256, KECCAK_PADDING, 256);
    k.update(privateKeyBytesToPublic(ethPrivateKey.privateKey));
    var hash = k.digest();
    int _shaBytes = 256 ~/ 8;
    hash = Uint8List.view(Uint8List.fromList(hash).buffer, _shaBytes - 20);

    EthereumAddress address = EthereumAddress(hash);
    //print(address.hexEip55);
    return address.hexEip55;
  }

  Future<String> seedToPrivateKey(String seed, int index) async {
    String pk = HEX.encode(bip32.BIP32
        .fromBase58(bip32.BIP32
            .fromSeed(bip39.mnemonicToSeed(bip39.entropyToMnemonic(seed)))
            .toBase58())
        .derivePath("m/44'/515'/0'/0/" + index.toString())
        .privateKey);
    //print(pk);
    return pk;
  }

  Future<void> loginAccount(BuildContext context) async {
    Account.Account selectedAcct =
        await sl.get<DBHelper>().getSelectedAccount();
    if (selectedAcct == null) {
      selectedAcct = Account.Account(
          index: 0,
          lastAccess: 0,
          name: AppLocalization.of(context).defaultAccountName,
          selected: true);
      await sl.get<DBHelper>().saveAccount(selectedAcct);
    }
    StateContainer.of(context).updateWallet(account: selectedAcct);
  }
}
