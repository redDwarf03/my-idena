import 'package:event_taxi/event_taxi.dart';
import 'package:my_idena/model/db/account.dart';

class AccountChangedEvent implements Event {
  final Account? account;
  final bool delayPop;
  final bool noPop;

  AccountChangedEvent({this.account, this.delayPop = false, this.noPop = false});
}