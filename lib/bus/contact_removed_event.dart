import 'package:event_taxi/event_taxi.dart';
import 'package:my_idena/model/db/contact.dart';

class ContactRemovedEvent implements Event {
  final Contact? contact;

  ContactRemovedEvent({this.contact});
}