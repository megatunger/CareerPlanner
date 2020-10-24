import 'package:careerplanner/ui/event/event_carousel_widget.dart';
import 'package:careerplanner/ui/home/home_header.dart';
import 'package:careerplanner/ui/home/home_shortcuts_widget.dart';
import 'package:careerplanner/ui/home/quiz_card/quiz_card.dart';
import 'package:careerplanner/ui/news/news_carousel_widget.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/router.dart';
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
                child: Column(
              children: [
                HomeShortcutWidget(
                    title: 'Tin Tức',
                    icon: Icons.wysiwyg_rounded,
                    callback: () {
                      Navigator.pushNamed(context, Routes.newsListRoute);
                    }),
                NewsCarouselWidget(
                    screenSize: MediaQuery.of(context).size,
                    stream:
                        constants.database.reference().child('news').onValue),
              ],
            )),
            SliverToBoxAdapter(
                child: Column(
              children: [
                HomeShortcutWidget(
                    title: 'Sự kiện',
                    icon: Icons.calendar_today,
                    callback: () {
                      Navigator.pushNamed(context, Routes.eventsListRoute);
                    }),
                SizedBox(height: 16),
                EventCarouselWidget(
                    screenSize: MediaQuery.of(context).size,
                    stream:
                        constants.database.reference().child('events').onValue),
              ],
            ))
          ])),
    );
  }
}
