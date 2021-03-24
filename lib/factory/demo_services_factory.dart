// @dart=2.9
import 'dart:async';
import 'package:logger/logger.dart';
import 'package:my_idena/factory/interfaces/iservices_factory.dart';
import 'package:my_idena/model/deepLinks/deepLinkParamSignin.dart';
import 'package:my_idena/network/model/response/bcn_mempool_response.dart';
import 'package:my_idena/network/model/response/bcn_send_raw_tx_response.dart';
import 'package:my_idena/network/model/response/bcn_transaction_response.dart';
import 'package:my_idena/network/model/response/dna_activate_invite_response.dart';
import 'package:my_idena/network/model/response/dna_send_invite_response.dart';
import 'package:my_idena/network/model/response/bcn_syncing_response.dart';
import 'package:my_idena/network/model/response/bcn_transactions_response.dart';
import 'package:my_idena/network/model/response/dna_becomeOffline_response.dart';
import 'package:my_idena/network/model/response/dna_becomeOnline_response.dart';
import 'package:my_idena/network/model/response/dna_ceremonyIntervals_response.dart';
import 'package:my_idena/network/model/response/dna_getBalance_response.dart';
import 'package:my_idena/network/model/response/dna_getCoinbaseAddr_response.dart';
import 'package:my_idena/network/model/response/dna_getEpoch_response.dart';
import 'package:my_idena/network/model/response/dna_identity_response.dart';
import 'package:my_idena/network/model/response/dna_sendTransaction_response.dart';
import 'package:my_idena/util/util_demo_mode.dart';

class DemoServicesFactory implements IServicesFactory {
  var logger = Logger();

  Future<DnaGetBalanceResponse> getBalanceGetResponse(
      String address, bool activeBus) async {
    DnaGetBalanceResponse dnaGetBalanceResponse = new DnaGetBalanceResponse();

    Completer<DnaGetBalanceResponse> _completer =
        new Completer<DnaGetBalanceResponse>();

    dnaGetBalanceResponse = new DnaGetBalanceResponse();
    dnaGetBalanceResponse.result = new DnaGetBalanceResponseResult();
    dnaGetBalanceResponse.result.balance = DM_PORTOFOLIO_MAIN;
    dnaGetBalanceResponse.result.stake = DM_PORTOFOLIO_STAKE;

    _completer.complete(dnaGetBalanceResponse);
    return _completer.future;
  }

  Future<int> getLastNonce(String address) async {
    Completer<int> _completer = new Completer<int>();
    _completer.complete(1);
    return _completer.future;
  }

  Future<BcnTransactionsResponse> getAddressTxsResponse(
      String address, int count) async {
    Completer<BcnTransactionsResponse> _completer =
        new Completer<BcnTransactionsResponse>();

    BcnTransactionsResponse bcnTransactionsResponse;
    bcnTransactionsResponse = new BcnTransactionsResponse();
    bcnTransactionsResponse.result = new BcnTransactionsResponseResult();

    _completer.complete(bcnTransactionsResponse);
    return _completer.future;
  }

  Future<String> getWStatusGetResponse() async {
    Completer<String> _completer = new Completer<String>();

    _completer.complete("true");
    return _completer.future;
  }

  Future<DnaGetCoinbaseAddrResponse> getDnaGetCoinbaseAddr() async {
    DnaGetCoinbaseAddrResponse dnaGetCoinbaseAddrResponse;

    Completer<DnaGetCoinbaseAddrResponse> _completer =
        new Completer<DnaGetCoinbaseAddrResponse>();

    dnaGetCoinbaseAddrResponse.result = DM_IDENTITY_ADDRESS;

    _completer.complete(dnaGetCoinbaseAddrResponse);
    return _completer.future;
  }

  Future<DnaIdentityResponse> getDnaIdentity(String address) async {
    DnaIdentityResponse dnaIdentityResponse;

    Completer<DnaIdentityResponse> _completer =
        new Completer<DnaIdentityResponse>();
    dnaIdentityResponse = new DnaIdentityResponse();
    dnaIdentityResponse.result = DnaIdentityResponseResult();
    dnaIdentityResponse.result.address = DM_IDENTITY_ADDRESS;
    dnaIdentityResponse.result.age = DM_IDENTITY_AGE;
    dnaIdentityResponse.result.state = DM_IDENTITY_STATE;
    dnaIdentityResponse.result.online = DM_IDENTITY_ONLINE;
    dnaIdentityResponse.result.flips = new List(DM_IDENTITY_MADE_FLIPS);
    dnaIdentityResponse.result.availableFlips =
        DM_IDENTITY_REQUIRED_FLIPS - DM_IDENTITY_MADE_FLIPS;
    dnaIdentityResponse.result.madeFlips = DM_IDENTITY_MADE_FLIPS;
    dnaIdentityResponse.result.requiredFlips = DM_IDENTITY_REQUIRED_FLIPS;
    dnaIdentityResponse.result.penalty = DM_IDENTITY_PENALTY;
    dnaIdentityResponse.result.invites = DM_INVITES;
    dnaIdentityResponse.result.totalQualifiedFlips =
        DM_IDENTITY_TOTAL_QUALIFIED_FLIPS;
    dnaIdentityResponse.result.totalShortFlipPoints =
        DM_IDENTITY_TOTAL_SHORT_FLIP_POINTS;
    List<int> _listWords1 = [DM_IDENTITY_KEYWORD_1, DM_IDENTITY_KEYWORD_2];
    dnaIdentityResponse.result.flipKeyWordPairs = new List<FlipKeyWordPair>();
    dnaIdentityResponse.result.flipKeyWordPairs
        .add(new FlipKeyWordPair(id: 1, words: _listWords1, used: false));
    List<int> _listWords2 = [DM_IDENTITY_KEYWORD_3, DM_IDENTITY_KEYWORD_4];
    dnaIdentityResponse.result.flipKeyWordPairs
        .add(new FlipKeyWordPair(id: 1, words: _listWords2, used: false));

    _completer.complete(dnaIdentityResponse);
    return _completer.future;
  }

  Future<DnaGetEpochResponse> getDnaGetEpoch() async {
    DnaGetEpochResponse dnaGetEpochResponse;

    Completer<DnaGetEpochResponse> _completer =
        new Completer<DnaGetEpochResponse>();

    dnaGetEpochResponse = new DnaGetEpochResponse();
    dnaGetEpochResponse.result = new DnaGetEpochResponseResult();
    dnaGetEpochResponse.result.currentPeriod = DM_EPOCH_CURRENT_PERIOD;
    dnaGetEpochResponse.result.epoch = DM_EPOCH_EPOCH;
    dnaGetEpochResponse.result.nextValidation = DM_EPOCH_NEXT_VALIDATION;

    _completer.complete(dnaGetEpochResponse);
    return _completer.future;
  }

  Future<DnaCeremonyIntervalsResponse> getDnaCeremonyIntervals() async {
    DnaCeremonyIntervalsResponse dnaCeremonyIntervalsResponse;

    Completer<DnaCeremonyIntervalsResponse> _completer =
        new Completer<DnaCeremonyIntervalsResponse>();

    dnaCeremonyIntervalsResponse = new DnaCeremonyIntervalsResponse();
    dnaCeremonyIntervalsResponse.result =
        new DnaCeremonyIntervalsResponseResult();
    dnaCeremonyIntervalsResponse.result.flipLotteryDuration =
        DM_CEREMONY_INTERVALS_FLIP_LOTTERY_DURATION;
    dnaCeremonyIntervalsResponse.result.longSessionDuration =
        DM_CEREMONY_INTERVALS_LONG_SESSION_DURATION;
    dnaCeremonyIntervalsResponse.result.shortSessionDuration =
        DM_CEREMONY_INTERVALS_SHORT_SESSION_DURATION;

    _completer.complete(dnaCeremonyIntervalsResponse);
    return _completer.future;
  }

  Future<String> getCurrentPeriod() async {
    String currentPeriod = DM_EPOCH_CURRENT_PERIOD;
    Completer<String> _completer = new Completer<String>();

    _completer.complete(currentPeriod);
    return _completer.future;
  }

  Future<DnaBecomeOnlineResponse> becomeOnline() async {
    throw "method not available";
  }

  Future<DnaBecomeOfflineResponse> becomeOffline() async {
    throw "method not available";
  }

  Future<DnaSendTransactionResponse> sendTip(
      String from, String amount, String seed) async {
    throw "method not available";
  }

  Future<DnaSendTransactionResponse> sendTx(String from, String amount,
      String to, String privateKey, String payload) async {
    throw "method not available";
  }

  Future<BcnSyncingResponse> checkSync() async {
    BcnSyncingResponse bcnSyncingResponse;

    Completer<BcnSyncingResponse> _completer =
        new Completer<BcnSyncingResponse>();

    bcnSyncingResponse = new BcnSyncingResponse();
    bcnSyncingResponse.result = new BcnSyncingResponseResult();
    bcnSyncingResponse.result.syncing = DM_SYNC_SYNCING;
    bcnSyncingResponse.result.currentBlock = DM_SYNC_CURRENT_BLOCK;
    bcnSyncingResponse.result.highestBlock = DM_SYNC_HIGHEST_BLOCK;

    _completer.complete(bcnSyncingResponse);
    return _completer.future;
  }

  double getFeesEstimation() {
    // TODO
    //print("getFeesEstimation: " + fees.toString());
    return 0.25;
  }

  Future<BcnMempoolResponse> getMemPool(String address) async {
    throw "method not available";
  }

  Future<BcnTransactionResponse> getTransaction(
      String hash, String address) async {
    throw "method not available";
  }

  Future<BcnSendRawTxResponse> sendRawTx(String rawTxSigned) async {
    throw "method not available";
  }

  Future<DnaActivateInviteResponse> activateInvitation(
      String key, String address) async {
    throw "method not available";
  }

  Future<DnaSendInviteResponse> sendInvitation(
      String address, String amount, int nonce, int epoch) async {
    throw "method not available";
  }

  Future<DeepLinkParamSignin> signin(
      DeepLinkParamSignin deepLinkParam, String privateKey) async {
    throw "method not available";
  }

  Future<int> getFeePerGas() async {
    int feePerGas = DM_FEE_PER_GAS;
    Completer<int> _completer = new Completer<int>();

    _completer.complete(feePerGas);
    return _completer.future;
  }
}
