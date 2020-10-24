import 'package:careerplanner/model/event/event_object.dart';
import 'package:firebase_database/firebase_database.dart';

class EventData {
  List<EventObject> events;

  EventData({this.events});

  factory EventData.fromSnapshot(DataSnapshot snapshot) {
    List<EventObject> eventsList = [];
    eventsList.clear();
    if (snapshot.value != null) {
      if (snapshot.value.runtimeType.toString() ==
          "_InternalLinkedHashMap<dynamic, dynamic>") {
        Map<String, dynamic>.from(snapshot.value).forEach((key, value) {
          eventsList
              .add(EventObject.fromJson(Map<String, dynamic>.from(value)));
        });
      } else {
        List<dynamic> values = snapshot.value;
        values.forEach((element) {
          if (element != null) {
            eventsList
                .add(EventObject.fromJson(Map<String, dynamic>.from(element)));
          }
        });
      }
    }
    return EventData(events: eventsList);
  }
}
