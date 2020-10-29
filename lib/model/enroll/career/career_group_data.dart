import 'package:careerplanner/model/enroll/career/career_group_object.dart';
import 'package:firebase_database/firebase_database.dart';

class CareerGroupData {
  List<CareerGroupObject> careerGroups;

  CareerGroupData({this.careerGroups});

  factory CareerGroupData.fromSnapshot(DataSnapshot snapshot) {
    List<CareerGroupObject> careerGroupsList = [];
    careerGroupsList.clear();
    if (snapshot.value.runtimeType.toString() ==
        "_InternalLinkedHashMap<dynamic, dynamic>") {
      Map<String, dynamic>.from(snapshot.value).forEach((key, value) {
        careerGroupsList
            .add(CareerGroupObject.fromJson(Map<String, dynamic>.from(value)));
      });
    } else {
      List<dynamic> values = snapshot.value;
      if (snapshot.value != null) {
        values.forEach((element) {
          if (element != null) {
            careerGroupsList.add(
                CareerGroupObject.fromJson(Map<String, dynamic>.from(element)));
          }
        });
      }
    }
    return CareerGroupData(careerGroups: careerGroupsList);
  }
}
