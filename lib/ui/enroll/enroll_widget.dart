import 'package:careerplanner/ui/enroll/career_list/career_list_carousel.dart';
import 'package:careerplanner/ui/enroll/career_list/career_list_header.dart';
import 'package:careerplanner/ui/enroll/university_list/university_bubbles_widget.dart';
import 'package:careerplanner/ui/enroll/university_list/university_list_header.dart';
import 'package:careerplanner/ui/enroll/university_list/university_show_all_button.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:flutter/material.dart';

class EnrollWidget extends StatefulWidget {
  EnrollWidget({Key key}) : super(key: key);

  @override
  _EnrollWidgetState createState() => _EnrollWidgetState();
}

class _EnrollWidgetState extends State<EnrollWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter:
              ColorFilter.mode(Colors.white.withOpacity(0.08), BlendMode.dstIn),
          image: AssetImage("assets/illustrations/4086124.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        children: [
          CareerListHeader(),
          SizedBox(height: 16),
          CareerListCarousel(
              screenSize: MediaQuery.of(context).size,
              stream: constants.database
                  .reference()
                  .child('career_list')
                  .limitToFirst(5)
                  .onValue),
          Divider(),
          UniversityListHeader(),
          UniversityBubblesWidget(
              stream: constants.database
                  .reference()
                  .child('university_list')
                  .limitToFirst(4)
                  .onValue),
          UniversityShowAllButton(),
          SizedBox(height: 64)
        ],
      ) /* add child content here */,
    ));
  }
}
