import 'package:careerplanner/ui/home/home_header.dart';
import 'package:careerplanner/ui/home/home_shortcuts_widget.dart';
import 'package:careerplanner/ui/home/quiz_card/quiz_card.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.08), BlendMode.dstIn),
              image: AssetImage("assets/illustrations/4086124.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomScrollView(slivers: [
            HomeHeader(),
            SliverToBoxAdapter(child: QuizCard()),
            SliverToBoxAdapter(
                child: HomeShortcutsWidget(
              sizeOfButton: MediaQuery.of(context).size.width * .1,
            ))
          ])),
    );
  }
}
