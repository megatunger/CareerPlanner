import 'package:careerplanner/ui/home/home_shortcuts_widget.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class QuizResultDidNotFinished extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/illustrations/hugo-list-is-empty.png'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16),
          child: Text(
            'Có vẻ như bạn chưa hoàn thành bài trắc nghiệm :(',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black87, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24),
          child: HomeShortcutWidget(
              title: 'Làm bài trắc nghiệm',
              icon: Icons.warning_rounded,
              color: CareerPlannerTheme.secondaryColor,
              callback: () {
                Navigator.pushReplacementNamed(context, Routes.quizCareerRoute);
              }),
        ),
      ],
    );
  }
}
