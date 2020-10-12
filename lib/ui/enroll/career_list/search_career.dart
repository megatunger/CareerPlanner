import 'package:careerplanner/model/enroll/CareerObject.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SearchCareer extends StatefulWidget {
  SearchCareer({Key key}) : super(key: key);
  final DatabaseReference careerListRef =
      constants.database.reference().child('career_list');
  @override
  _SearchCareerState createState() => _SearchCareerState();
}

class _SearchCareerState extends State<SearchCareer> {
  Future<List<CareerObject>> search(String search) async {
    await this.widget.careerListRef.once().then((value) {
      return convertToList(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container())),
    );
  }

  List<CareerObject> convertToList(DataSnapshot data) {
    List<CareerObject> careerList = [];
    careerList.clear();
    List<dynamic> values = data.value;
    values.forEach((element) {
      if (element != null) {
        careerList
            .add(CareerObject.fromJson(Map<String, dynamic>.from(element)));
      }
    });
    return careerList;
  }
}
