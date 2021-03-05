import 'package:my_idena/model/deepLinks/deepLinkParamSignin.dart';
import 'package:my_idena/network/model/response/bcn_mempool_response.dart';
import 'package:my_idena/network/model/response/bcn_send_raw_tx_response.dart';
import 'package:my_idena/network/model/response/bcn_syncing_response.dart';
import 'package:my_idena/network/model/response/bcn_transaction_response.dart';
import 'package:my_idena/network/model/response/bcn_transactions_response.dart';
import 'package:my_idena/network/model/response/dna_activate_invite_response.dart';
import 'package:my_idena/network/model/response/dna_becomeOffline_response.dart';
import 'package:my_idena/network/model/response/dna_becomeOnline_response.dart';
import 'package:my_idena/network/model/response/dna_ceremonyIntervals_response.dart';
import 'package:my_idena/network/model/response/dna_getBalance_response.dart';
import 'package:my_idena/network/model/response/dna_getCoinbaseAddr_response.dart';
import 'package:my_idena/network/model/response/dna_getEpoch_response.dart';
import 'package:my_idena/network/model/response/dna_identity_response.dart';
import 'package:my_idena/network/model/response/dna_sendTransaction_response.dart';
import 'package:my_idena/network/model/response/dna_send_invite_response.dart';

abstract class IServicesFactory {

  Future<DnaGetBalanceResponse> getBalanceGetResponse(
      String address, bool activeBus);

  Future<int> getLastNonce(String address);

  Future<BcnTransactionsResponse> getAddressTxsResponse(
      String address, int count);

  Future<bool> getWStatusGetResponse();

  Future<DnaGetCoinbaseAddrResponse> getDnaGetCoinbaseAddr();

  Future<DnaIdentityResponse> getDnaIdentity(String address);

  Future<DnaGetEpochResponse> getDnaGetEpoch();

  Future<DnaCeremonyIntervalsResponse> getDnaCeremonyIntervals();

  Future<String> getCurrentPeriod();

  Future<DnaBecomeOnlineResponse> becomeOnline();

  Future<DnaBecomeOfflineResponse> becomeOffline();

  Future<DnaSendTransactionResponse> sendTip(
      String from, String amount, String seed);

  Future<DnaSendTransactionResponse> sendTx(
      String from, String amount, String to, String privateKey, String payload);

  Future<BcnSyncingResponse> checkSync();

  double getFeesEstimation();

  Future<BcnMempoolResponse> getMemPool(String address);

  Future<BcnTransactionResponse> getTransaction(String hash, String address);

  Future<BcnSendRawTxResponse> sendRawTx(String rawTxSigned);

  Future<DnaActivateInviteResponse> activateInvitation(
      String key, String address);

  Future<DnaSendInviteResponse> sendInvitation(
      String address, String amount, int nonce, int epoch);

  Future<DeepLinkParamSignin> signin(
      DeepLinkParamSignin deepLinkParam, String privateKey);

  Future<int> getFeePerGas();
}
