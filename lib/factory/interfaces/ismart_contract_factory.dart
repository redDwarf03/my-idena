import 'package:my_idena/network/model/request/contract/api_contract_balance_updates_response.dart';
import 'package:my_idena/network/model/request/contract/api_contract_response.dart';
import 'package:my_idena/network/model/request/contract/api_contract_txs_response.dart';
import 'package:my_idena/network/model/response/bcn_tx_receipt_response.dart';
import 'package:my_idena/network/model/response/contract/contract_call_response.dart';
import 'package:my_idena/network/model/response/contract/contract_deploy_response.dart';
import 'package:my_idena/network/model/response/contract/contract_estimate_deploy_response.dart';
import 'package:my_idena/network/model/response/contract/contract_get_stake_response.dart';
import 'package:my_idena/network/model/response/contract/contract_terminate_response.dart';

abstract class ISmartContractFactory {
  Future<BcnTxReceiptResponse> getTxReceipt(String txHash);

  Future<String> getPredictSmartContractAddress(String address);

  Future<ContractDeployResponse> contractDeployTimeLock(
      String owner, int timestamp, double amount, double maxFee);

  Future<ContractDeployResponse> contractDeployMultiSig(
      String owner, int maxVotes, int minVotes, double amount, double maxFee);

  Future<ContractEstimateDeployResponse> contractEstimateDeployTimeLock(
      String owner, int timestamp, double amount);

  Future<ContractEstimateDeployResponse> contractEstimateDeployMultiSig(
      String owner, int maxVotes, int minVotes, double amount);

  Future<ContractCallResponse> contractCallTransferTimeLock(String owner,
      String contract, double maxFee, String destinationAddress, String amount);

  Future<ContractCallResponse> contractCallSendMultiSig(String owner,
      String contract, double maxFee, String destinationAddress, String amount);

  Future<String> getMultiSigToSend(String address);

  Future<ContractCallResponse> contractCallAddMultiSig(
      String owner,
      String contract,
      double maxFee,
      String destinationAddress,
      String privateKey);

  Future<ContractCallResponse> contractCallPushMultiSig(String owner,
      String contract, double maxFee, String destinationAddress, String amount);

  Future<ContractTerminateResponse> contractTerminateTimeLock(
      String owner, String contract, double maxFee, String destinationAddress);

  Future<ContractTerminateResponse> contractTerminateMultiSig(
      String owner, String contract, double maxFee, String destinationAddress);

  Future<ApiContractResponse> getContract(String contractAddress);

  Future<ApiContractBalanceUpdatesResponse> getContractBalanceUpdates(
      String address, String contractAddress, int limit);

  Future<ApiContractTxsResponse> getContractTxs(
      String address, int limit, String typeOfContract);

  Future<int> getContractReadDataUint64(String contractAddress, String key);

  Future<String> getContractReadDataHex(String contractAddress, String key);

  Future<int> getContractReadDataByte(String contractAddress, String key);

  Future<ContractGetStakeResponse> getContractStake(String contractAddress);

  Future<double> getSmartContractStake();
}
