import 'package:careerplanner/model/account/mentor_object.dart';
import 'package:careerplanner/ui/home/home_shortcuts_widget.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class ListingThreadsMentorWidget extends StatefulWidget {
  ListingThreadsMentorWidget({Key key, this.mentor}) : super(key: key);
  final MentorObject mentor;
  @override
  _ListingThreadsMentorWidgetState createState() =>
      _ListingThreadsMentorWidgetState();
}

class _ListingThreadsMentorWidgetState
    extends State<ListingThreadsMentorWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Các chủ đề đang thảo luận',
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: CareerPlannerTheme.thirdColor,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: HomeShortcutWidget(
                title: 'Tạo chủ đề',
                icon: Icons.edit,
                color: CareerPlannerTheme.primaryColor,
                callback: () {
                  Navigator.pushNamed(context, Routes.connectNewThreadRoute);
                }),
          ),
        ]);
  }
}
