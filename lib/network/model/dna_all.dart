
import 'request/bcn_transactions_request.dart';
import 'response/bcn_transactions_response.dart';
import 'request/dna_ceremonyIntervals_request.dart';
import 'response/dna_ceremonyIntervals_response.dart';
import 'request/dna_getBalance_request.dart';
import 'response/dna_getBalance_response.dart';
import 'request/dna_getCoinbaseAddr_request.dart';
import 'response/dna_getCoinbaseAddr_response.dart';
import 'request/dna_getEpoch_request.dart';
import 'response/dna_getEpoch_response.dart';
import 'request/dna_identity_request.dart';
import 'response/dna_identity_response.dart';

class DnaAll {
    DnaAll({
        this.dnaGetCoinbaseAddrRequest,
        this.dnaGetCoinbaseAddrResponse,
        this.dnaIdentityRequest,
        this.dnaIdentityResponse,
        this.dnaGetBalanceRequest,
        this.dnaGetBalanceResponse,
        this.dnaGetEpochRequest,
        this.dnaGetEpochResponse,
        this.dnaCeremonyIntervalsRequest,
        this.dnaCeremonyIntervalsResponse,
        this.bcnTransactionsRequest,
        this.bcnTransactionsResponse,
    });

  DnaGetCoinbaseAddrRequest dnaGetCoinbaseAddrRequest;
  DnaGetCoinbaseAddrResponse dnaGetCoinbaseAddrResponse;
  DnaIdentityRequest dnaIdentityRequest;
  DnaIdentityResponse dnaIdentityResponse;
  DnaGetBalanceRequest dnaGetBalanceRequest;
  DnaGetBalanceResponse dnaGetBalanceResponse;
  DnaGetEpochRequest dnaGetEpochRequest;
  DnaGetEpochResponse dnaGetEpochResponse;
  DnaCeremonyIntervalsRequest dnaCeremonyIntervalsRequest;
  DnaCeremonyIntervalsResponse dnaCeremonyIntervalsResponse;
  BcnTransactionsRequest bcnTransactionsRequest;
  BcnTransactionsResponse bcnTransactionsResponse;
}