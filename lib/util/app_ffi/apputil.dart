// @dart=2.9
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
import 'package:web3dart/web3dart.dart';

class AppUtil {
  Future<String> getAddress() async {
    String address = await sl.get<SharedPrefsUtil>().getAddress();
    if (address == "") {
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
              .then((value) => address = value);
          await UtilCrypto()
              .encryptedPrivateKeyToSeed(
                  await sl.get<SharedPrefsUtil>().getEncryptedPk(),
                  await sl.get<SharedPrefsUtil>().getPasswordPk())
              .then((value) => sl.get<Vault>().setSeed(value));
        }
      }
    }

    //print("address : " + address);
    return address;
  }

  Future<String> seedToAddress(
      String seed, int index, String seedOrigin) async {
    String mnemonic = bip39.entropyToMnemonic(seed);
    //print('mnemonic: ' + mnemonic);

    EthereumAddress address;
    EthPrivateKey ethPrivateKey;
    if (seedOrigin == null || seedOrigin == HD_WALLET) {
      ethPrivateKey = EthPrivateKey.fromHex(
          await seedToPrivateKey(seed, index));
    } else {
      ethPrivateKey = EthPrivateKey.fromHex(
          AppMnemomics.mnemonicListToSeed(mnemonic.split(' ')));
    }
    address = await ethPrivateKey.extractAddress();
    return address.hexEip55;
  }

  Future<String> seedToPrivateKey(
      String seed, int index) async {
    return HEX.encode(bip32.BIP32
        .fromBase58(bip32.BIP32
            .fromSeed(bip39.mnemonicToSeed(bip39.entropyToMnemonic(seed)))
            .toBase58())
        .derivePath("m/44'/515'/0'/0/" + index.toString())
        .privateKey);
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
