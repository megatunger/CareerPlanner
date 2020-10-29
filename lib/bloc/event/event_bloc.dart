import 'package:careerplanner/model/event/event_object.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventBloc {
  final user = FirebaseAuth.instance.currentUser;

  void registerEvent({EventObject event, bool register}) {
    final data = {
      "uid": user.uid,
      "email": "${user.email}",
      "event_id": event.id,
      "event_name": event.eventName,
      "register": register,
      "timestamp": DateTime.now().millisecondsSinceEpoch
    };
    constants.database.reference().child("event_registrations").update(data);
  }
}

final eventBloc = EventBloc();
