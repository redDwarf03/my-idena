import 'package:my_idena/beans/rpc/dna_all.dart';
import 'package:my_idena/utils/identityStatus.dart' as IdentityStatus;


class UtilIdentity {

  bool canValidate(DnaAll dnaAll) {
    if (dnaAll.dnaIdentityResponse == null) {
      return false;
    }
    int numOfFlipsToSubmit = dnaAll.dnaIdentityResponse.result.requiredFlips -
        dnaAll.dnaIdentityResponse.result.flips.length;
    bool shouldSendFlips = numOfFlipsToSubmit > 0;
    var identityStatus1 = [
      IdentityStatus.Human,
      IdentityStatus.Verified,
      IdentityStatus.Newbie
    ];
    var identityStatus2 = [
      IdentityStatus.Candidate,
      IdentityStatus.Suspended,
      IdentityStatus.Zombie
    ];

    return ((identityStatus1
                .contains(dnaAll.dnaIdentityResponse.result.state) &&
            !shouldSendFlips) ||
        identityStatus2.contains(dnaAll.dnaIdentityResponse.result.state));
  }

  bool canMine(DnaAll dnaAll) {
    var identityStatus1 = [
      IdentityStatus.Human,
      IdentityStatus.Verified,
      IdentityStatus.Newbie
    ];
    return (identityStatus1.contains(dnaAll.dnaIdentityResponse.result.state));
  }

  bool canTerminate(DnaAll dnaAll) {
    var identityStatus1 = [
      IdentityStatus.Candidate,
      IdentityStatus.Verified,
      IdentityStatus.Suspended,
      IdentityStatus.Zombie,
      IdentityStatus.Human
    ];
    return (identityStatus1.contains(dnaAll.dnaIdentityResponse.result.state));
  }

  bool canSubmitFlip(DnaAll dnaAll) {
    var identityStatus1 = [
      IdentityStatus.Newbie,
      IdentityStatus.Verified,
      IdentityStatus.Human
    ];
    return (identityStatus1.contains(dnaAll.dnaIdentityResponse.result.state) &&
        dnaAll.dnaIdentityResponse.result.requiredFlips > 0 &&
        (dnaAll.dnaIdentityResponse.result.flips.length <
            dnaAll.dnaIdentityResponse.result.availableFlips));
  }

  bool canActivateInvite(DnaAll dnaAll) {
    var identityStatus1 = [IdentityStatus.Undefined, IdentityStatus.Invite];
    return (identityStatus1.contains(dnaAll.dnaIdentityResponse.result.state));
  }

  String mapToFriendlyStatus(status) {
    switch (status) {
      case IdentityStatus.Undefined:
        return "Not validated";
      default:
        return status;
    }
  }
}
