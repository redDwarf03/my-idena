import 'package:my_idena/network/model/dna_all.dart';
import 'package:my_idena/util/enums/identity_status.dart' as IdentityStatus;
import 'package:my_idena/network/model/response/dna_identity_response.dart';

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
  int canValidate(DnaIdentityResponse dnaIdentityResponse) {
    if (dnaIdentityResponse == null) {
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

    if (identityStatus3.contains(dnaIdentityResponse.result.state)) {
      return WRONG_STATUS;
    }

    if (identityStatus2.contains(dnaIdentityResponse.result.state)) {
      return CAN_VALIDATE;
    } else {
      bool shouldSendFlips = true;
      if (identityStatus1.contains(dnaIdentityResponse.result.state)) {
        try {
          if (dnaIdentityResponse.result.flips != null) {
            int numOfFlipsToSubmit = dnaIdentityResponse.result.requiredFlips -
                dnaIdentityResponse.result.flips.length;
            shouldSendFlips = numOfFlipsToSubmit > 0;
          } else {
            shouldSendFlips = false;
          }
        } catch (e) {}
      }

      if (identityStatus1.contains(dnaIdentityResponse.result.state) &&
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

  bool canMine(String state) {
    var identityStatus1 = [
      IdentityStatus.Human,
      IdentityStatus.Verified,
      IdentityStatus.Newbie
    ];
    return (identityStatus1.contains(state));
  }

  bool canTerminate(String state) {
    var identityStatus1 = [
      IdentityStatus.Candidate,
      IdentityStatus.Verified,
      IdentityStatus.Suspended,
      IdentityStatus.Zombie,
      IdentityStatus.Human
    ];
    return (identityStatus1.contains(state));
  }

  bool canSubmitFlip(DnaIdentityResponse dnaIdentityResponse) {
    var identityStatus1 = [
      IdentityStatus.Newbie,
      IdentityStatus.Verified,
      IdentityStatus.Human
    ];
    return (identityStatus1.contains(dnaIdentityResponse.result.state) &&
        dnaIdentityResponse.result.requiredFlips > 0 &&
        (dnaIdentityResponse.result.flips == null ||
            (dnaIdentityResponse.result.flips.length <
                dnaIdentityResponse.result.availableFlips)));
  }

  bool canActivateInvite(String state) {
    var identityStatus1 = [IdentityStatus.Undefined, IdentityStatus.Invite];
    return (identityStatus1.contains(state));
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
