import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class UniversityShowAllButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 48),
      child: FlatButton(
        child: Text('Danh Sách Các Cơ Sở Đào Tạo'),
        color: CareerPlannerTheme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        textColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.universityAllRoute);
        },
      ),
    );
  }
}
