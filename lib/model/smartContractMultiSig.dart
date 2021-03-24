import 'package:my_idena/network/model/request/contract/api_contract_balance_updates_response.dart';

class SmartContractMultiSig {
  double? balance;
  double? stake;
  String? type;
  int? maxVotes;
  int? minVotes;
  int? state;
  int? count;
  int? nbVotesDone;
  String? owner;
  String? contractAddress;

  List<ApiContractBalanceUpdatesResponseResult>? balanceUpdates;

  ApiContractBalanceUpdatesResponseResult? getLastBalanceUpdates() {
  if (this.balanceUpdates != null) {
      for(int i = 0; i< this.balanceUpdates!.length; i++)
      {
          if(this.balanceUpdates![i].txReceipt != null)
          {
            return this.balanceUpdates![i];
          }
      }
      return null;
    } else {
      return null;
    }
  }

  List<ApiContractBalanceUpdatesResponseResult>? getReverseBalanceUpdates() {
    if (this.balanceUpdates != null) {
      List<ApiContractBalanceUpdatesResponseResult> resultReversed;
      resultReversed = this.balanceUpdates!;
      return resultReversed.reversed.toList();
    } else {
      return null;
    }
  }
}
