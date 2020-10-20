import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class HomeShortcutsWidget extends StatelessWidget {
  final double sizeOfButton;

  const HomeShortcutsWidget({Key key, this.sizeOfButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, right: 16, left: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: functionCard(
                    title: 'Sự kiện',
                    icon: Icons.calendar_today_outlined,
                    callback: () {
                      Navigator.pushNamed(context, Routes.eventsListRoute);
                    }),
              ),
              Expanded(
                child: functionCard(
                    title: 'Tin Tức',
                    icon: Icons.wysiwyg_rounded,
                    callback: () {
                      Navigator.pushNamed(context, Routes.newsListRoute);
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget functionCard({String title, IconData icon, VoidCallback callback}) {
    return Card(
        elevation: 0,
        color: CareerPlannerTheme.thirdColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: GestureDetector(
            onTap: callback,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icon, color: Colors.white),
                    Text(
                      '$title',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                  ]),
            )));
  }
}
