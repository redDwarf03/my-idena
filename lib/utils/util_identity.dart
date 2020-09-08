import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/utils/identityStatus.dart' as IdentityStatus;

class UtilIdentity {
  bool isCeremonyCandidate(DnaAll dnaAll) {
    if (dnaAll.dnaIdentityResponse == null) {
      return false;
    }
    var identityStatus1 = [
      IdentityStatus.Candidate,
      IdentityStatus.Newbie,
      IdentityStatus.Verified,
      IdentityStatus.Human,
      IdentityStatus.Suspended,
      IdentityStatus.Zombie,
    ];
    return (dnaAll.dnaIdentityResponse.result.madeFlips >=
            dnaAll.dnaIdentityResponse.result.requiredFlips &&
        identityStatus1.contains(dnaAll.dnaIdentityResponse.result.state));
  }

  bool canValidate(DnaAll dnaAll) {
    if (dnaAll == null || dnaAll.dnaIdentityResponse == null) {
      return false;
    }
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

    bool shouldSendFlips = true;
    if (identityStatus1.contains(dnaAll.dnaIdentityResponse.result.state)) {
      try {
        int numOfFlipsToSubmit =
            dnaAll.dnaIdentityResponse.result.requiredFlips -
                dnaAll.dnaIdentityResponse.result.flips.length;
        shouldSendFlips = numOfFlipsToSubmit > 0;
      } catch (e) {}
    }

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
