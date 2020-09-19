import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/enums/identity_status.dart' as IdentityStatus;

const int CAN_VALIDATE = 0;
const int WRONG_STATUS = 1;
const int FLIPS_REQUIRED = 2;

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

  // 1 =
  int canValidate(DnaAll dnaAll) {
    if (dnaAll == null || dnaAll.dnaIdentityResponse == null) {
      return WRONG_STATUS;
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

    var identityStatus3 = [
      IdentityStatus.Terminating,
      IdentityStatus.Undefined,
      IdentityStatus.Invite,
    ];

    if (identityStatus3.contains(dnaAll.dnaIdentityResponse.result.state)) {
      return WRONG_STATUS;
    }

    if (identityStatus2.contains(dnaAll.dnaIdentityResponse.result.state)) {
      return CAN_VALIDATE;
    } else {
      bool shouldSendFlips = true;
      if (identityStatus1.contains(dnaAll.dnaIdentityResponse.result.state)) {
        try {
          int numOfFlipsToSubmit =
              dnaAll.dnaIdentityResponse.result.requiredFlips -
                  dnaAll.dnaIdentityResponse.result.flips.length;
          shouldSendFlips = numOfFlipsToSubmit > 0;
        } catch (e) {}
      }

      if (identityStatus1.contains(dnaAll.dnaIdentityResponse.result.state) &&
          !shouldSendFlips) {
        return CAN_VALIDATE;
      } else {
        if (shouldSendFlips == false) {
          return WRONG_STATUS;
        } else {
          return FLIPS_REQUIRED;
        }
      }
    }
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
