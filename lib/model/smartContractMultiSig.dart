import 'package:my_idena/network/model/request/contract/api_contract_balance_updates_response.dart';

class SmartContractMultiSig {
  double balance;
  String type;
  int maxVotes;
  int minVotes;
  int state;
  int count;
  String owner;
  String contractAddress;

  List<ApiContractBalanceUpdatesResponseResult> balanceUpdates;

  ApiContractBalanceUpdatesResponseResult getLastBalanceUpdates() {
    if (this.balanceUpdates != null) {
      return this.balanceUpdates[0];
    } else {
      return null;
    }
  }

  List<ApiContractBalanceUpdatesResponseResult> getReverseBalanceUpdates() {
    if (this.balanceUpdates != null) {
      List<ApiContractBalanceUpdatesResponseResult> resultReversed;
      resultReversed = this.balanceUpdates;
      return resultReversed.reversed.toList();
    } else {
      return null;
    }
  }
}
