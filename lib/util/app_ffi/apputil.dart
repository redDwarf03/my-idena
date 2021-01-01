import 'package:flutter/material.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/db/account.dart' as Account;
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/network/model/response/dna_getCoinbaseAddr_response.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:my_idena/util/util_crypto.dart';
import 'package:my_idena/util/util_demo_mode.dart';
import 'package:my_idena/util/util_public_node.dart';

class AppUtil {
  Future<String> getAddress() async {
    String address = "";
    if (await DemoModeUtil().getDemoModeStatus()) {
      address = DM_IDENTITY_ADDRESS;
    } else {
      if (await PublicNodeUtil().getPublicNode() == false) {
        DnaGetCoinbaseAddrResponse dnaGetCoinbaseAddrResponse = await AppService().getDnaGetCoinbaseAddr();
        address = dnaGetCoinbaseAddrResponse == null ? "" : dnaGetCoinbaseAddrResponse.result;
      } else {
        await UtilCrypto()
            .encryptedPrivateKeyToAddress(
                await sl.get<SharedPrefsUtil>().getEncryptedPk(),
                await sl.get<SharedPrefsUtil>().getPasswordPk())
            .then((value) => address = value);
      }
    }
    //print("address : " + address);
    return address;
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
