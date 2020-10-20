import 'package:careerplanner/model/enroll/career/career_object.dart';
import 'package:firebase_database/firebase_database.dart';

class CareerData {
  List<CareerObject> careers;

  CareerData({this.careers});

  factory CareerData.fromSnapshot(DataSnapshot snapshot) {
    List<CareerObject> careerList = [];
    careerList.clear();
    List<dynamic> values = snapshot.value;
    values.forEach((element) {
      if (element != null) {
        careerList
            .add(CareerObject.fromJson(Map<String, dynamic>.from(element)));
      }
    });
    return CareerData(careers: careerList);
  }
}
