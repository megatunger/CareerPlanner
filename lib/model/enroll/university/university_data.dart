import 'package:careerplanner/model/enroll/university/university_object.dart';
import 'package:firebase_database/firebase_database.dart';

class UniversityData {
  List<UniversityObject> universities;

  UniversityData({this.universities});

  factory UniversityData.fromSnapshot(DataSnapshot snapshot) {
    List<UniversityObject> data = [];
    if (snapshot.value != null) {
      if (snapshot.value.runtimeType.toString() ==
          "_InternalLinkedHashMap<dynamic, dynamic>") {
        Map<String, dynamic>.from(snapshot.value).forEach((key, value) {
          data.add(UniversityObject.fromJson(Map<String, dynamic>.from(value)));
        });
      } else {
        List<dynamic> values = snapshot.value;
        values.forEach((element) {
          if (element != null) {
            data.add(
                UniversityObject.fromJson(Map<String, dynamic>.from(element)));
          }
        });
      }
    }
    return UniversityData(universities: data);
  }
}
