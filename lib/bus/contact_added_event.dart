// Package imports:
import 'package:event_taxi/event_taxi.dart';

// Project imports:
import 'package:my_idena/model/db/contact.dart';

class ContactAddedEvent implements Event {
  final Contact? contact;

  ContactAddedEvent({this.contact});
}
