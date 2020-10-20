import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class QuizCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.quizCareerRoute);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.22,
          child: Card(
            semanticContainer: true,
            color:
                TinyColor(CareerPlannerTheme.secondaryColor).darken(20).color,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                    tag: 'quiz_cover',
                    child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.srcOver),
                        child: Image.asset(
                          'assets/illustrations/clip-business-start-up-concept.png',
                          fit: BoxFit.cover,
                        ))),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 32, 32, 16),
                        child: Text(
                          'Trắc Nghiệm\nHướng Nghiệp',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.left,
                        ))),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.arrow_forward_ios_rounded, size: 36, color: Colors.white),
                    ))
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
