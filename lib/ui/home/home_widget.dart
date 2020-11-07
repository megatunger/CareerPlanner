import 'package:careerplanner/ui/event/event_carousel_widget.dart';
import 'package:careerplanner/ui/home/home_header.dart';
import 'package:careerplanner/ui/home/home_shortcuts_widget.dart';
import 'package:careerplanner/ui/home/quiz_card/quiz_card.dart';
import 'package:careerplanner/ui/news/news_carousel_widget.dart';
import 'package:careerplanner/util/ads_helper.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
  }

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: Text(
                    'Tin tức nổi bật',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: CareerPlannerTheme.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.left,
                  ),
                ),
                NewsCarouselWidget(
                    screenSize: MediaQuery.of(context).size,
                    stream:
                        constants.database.reference().child('news').onValue),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: HomeShortcutWidget(
                      title: 'Tin Tức',
                      icon: Icons.wysiwyg_rounded,
                      color: CareerPlannerTheme.thirdColor,
                      callback: () {
                        Navigator.pushNamed(context, Routes.newsListRoute);
                      }),
                ),
              ],
            )),
            SliverToBoxAdapter(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: Text(
                    'Sự kiện nổi bật',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: CareerPlannerTheme.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 16),
                EventCarouselWidget(
                    screenSize: MediaQuery.of(context).size,
                    stream:
                        constants.database.reference().child('events').onValue),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: HomeShortcutWidget(
                      title: 'Sự kiện',
                      icon: Icons.calendar_today,
                      color: CareerPlannerTheme.thirdColor,
                      callback: () {
                        Navigator.pushNamed(context, Routes.eventsListRoute);
                      }),
                ),
              ],
            ))
          ])),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
