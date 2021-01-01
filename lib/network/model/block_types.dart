import 'package:flutter/material.dart';
import 'package:my_idena/localization.dart';

class BlockTypes {
  /*static const String SEND = "Send";
  static const String RECEIVE = "receive";
  static const String CALL_CONTRACT = "CallContract";
  static const String VALIDATION_EVIDENCE = "Validation evidence";
  static const String LONG_SESSION_ANSWERS = "Long session answers";
  static const String SHORT_SESSION_ANSWERS = "Short session answers";
  static const String SHORT_SESSION_PROOF = "Short answers proof";
  static const String ISSUE_INVITATION = "Issue invitation";
  static const String SUBMIT_FLIP = "Submit flip";
  static const String MINIG_STATUS_ON = "Mining status On";
  static const String MINIG_STATUS_OFF = "Mining status Off";*/

  static const hiddenTypes = [
    'evidence',
    'submitShortAnswers',
    'submitLongAnswers',
    'submitAnswersHash',
  ];

  bool isHiddenType(String type) {
    if (type == null || hiddenTypes.contains(type) == false) {
      return false;
    } else {
      return true;
    }
  }

  String getTransactionTypeLabel(
      String type, String payload, BuildContext context) {
    if (type == 'send') return AppLocalization.of(context).typeTransfer;
    if (type == 'activation')
      return AppLocalization.of(context).typeInvitationActivated;
    if (type == 'invite')
      return AppLocalization.of(context).typeInvitationIssued;
    if (type == 'killInvitee')
      return AppLocalization.of(context).typeInvitationTerminated;
    if (type == 'kill')
      return AppLocalization.of(context).typeIdentityTerminated;
    if (type == 'submitFlip')
      return AppLocalization.of(context).typeFlipSubmitted;
    if (type == 'online') {
      if (payload != null && payload == '0x') {
        return AppLocalization.of(context).typeMiningStatusOff;
      } else {
        return AppLocalization.of(context).typeMiningStatusOn;
      }
    }
    if (type == 'deployContract') return AppLocalization.of(context).typeDeploy;
    if (type == 'terminateContract')
      return AppLocalization.of(context).typeDeploy;
    if (type == 'callContract') {
      // TODO Finir (c'est quoi receipt et method ?)
      String method = "";
      //method == receipt ? receipt.method : 'unknown'
      if (method == 'sendVote')
        return AppLocalization.of(context).typeCallContractSendVote;
      if (method == 'sendVoteProof')
        return AppLocalization.of(context).typeCallContractSendVoteProof;
      if (method == 'startVoting')
        return AppLocalization.of(context).typeCallContractStartVoting;
      if (method == 'finishVoting')
        return AppLocalization.of(context).typeCallContractFinishVoting;
      if (method == 'prolongVoting')
        return AppLocalization.of(context).typeCallContractProlongVoting;
    }
    return "";
  }
}
