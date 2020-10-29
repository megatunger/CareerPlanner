import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class QuizResultHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 24,
      automaticallyImplyLeading: true,
      expandedHeight: MediaQuery.of(context).size.height * 0.2,
      stretch: true,
      pinned: true,
      backgroundColor: CareerPlannerTheme.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [
          StretchMode.zoomBackground,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.asset(
                  'assets/illustrations/clip-business-start-up-concept.png',
                  fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kết quả phân tích',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
