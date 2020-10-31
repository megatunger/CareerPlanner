import 'package:careerplanner/model/account/mentor_object.dart';
import 'package:firebase_database/firebase_database.dart';

class MentorsData {
  List<MentorObject> mentors;

  MentorsData({this.mentors});

  factory MentorsData.fromSnapshot(DataSnapshot snapshot) {
    List<MentorObject> mentorsList = [];
    mentorsList.clear();
    if (snapshot.value != null) {
      if (snapshot.value.runtimeType.toString() ==
          "_InternalLinkedHashMap<dynamic, dynamic>") {
        Map<String, dynamic>.from(snapshot.value).forEach((key, value) {
          if (value["verify"] == 'x') {
            mentorsList
                .add(MentorObject.fromJson(Map<String, dynamic>.from(value)));
          }
        });
      } else {
        List<dynamic> values = snapshot.value;
        values.forEach((element) {
          if (element != null) {
            if (element["verify"] == 'x') {
              mentorsList.add(
                  MentorObject.fromJson(Map<String, dynamic>.from(element)));
            }
          }
        });
      }
    }
    return MentorsData(mentors: mentorsList);
  }
}
