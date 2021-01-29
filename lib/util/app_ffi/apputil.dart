import 'package:flutter/material.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/db/account.dart' as Account;
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/network/model/response/dna_getCoinbaseAddr_response.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/util/app_ffi/keys/mnemonics.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:my_idena/util/util_crypto.dart';
import 'package:my_idena/util/util_demo_mode.dart';
import 'package:my_idena/util/util_node.dart';
import 'package:bip39/bip39.dart' as bip39;
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
        }
      }
    }

    //print("address : " + address);
    return address;
  }

  Future<String> seedToAddress(String seed, int index) async {
    String mnemonic = bip39.entropyToMnemonic(seed);
    //print('mnemonic: ' + mnemonic);
    
    Credentials fromHex = EthPrivateKey.fromHex(AppMnemomics.mnemonicListToSeed(mnemonic.split(' ')));
    var address = await fromHex.extractAddress();
    //print(address.hex);

    return address.hex;
  }

  Future<String> seedToPublicKeyBase64(String seed, int index) async {
    return "";
  }

  Future<String> seedToPrivateKey(String seed, int index) async {
    return "";
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
