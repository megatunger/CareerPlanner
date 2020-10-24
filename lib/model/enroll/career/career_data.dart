import 'package:careerplanner/model/enroll/career/career_object.dart';
import 'package:firebase_database/firebase_database.dart';

class CareerData {
  List<CareerObject> careers;

  CareerData({this.careers});

  factory CareerData.fromSnapshot(DataSnapshot snapshot) {
    List<CareerObject> careerList = [];
    careerList.clear();
    if (snapshot.value.runtimeType.toString() ==
        "_InternalLinkedHashMap<dynamic, dynamic>") {
      Map<String, dynamic>.from(snapshot.value).forEach((key, value) {
        careerList.add(CareerObject.fromJson(Map<String, dynamic>.from(value)));
      });
    } else {
      List<dynamic> values = snapshot.value;
      if (snapshot.value != null) {
        values.forEach((element) {
          if (element != null) {
            careerList
                .add(CareerObject.fromJson(Map<String, dynamic>.from(element)));
          }
        });
      }
    }
    return CareerData(careers: careerList);
  }
}
