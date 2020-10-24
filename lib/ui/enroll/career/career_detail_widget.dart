import 'package:careerplanner/model/enroll/career/career_object.dart';
import 'package:careerplanner/ui/enroll/career/career_detail_header_widget.dart';
import 'package:careerplanner/ui/enroll/career_list/career_list_carousel.dart';
import 'package:careerplanner/ui/enroll/university_list/university_bubbles_widget.dart';
import 'package:careerplanner/ui/event/event_carousel_widget.dart';
import 'package:careerplanner/ui/news/news_carousel_widget.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CareerDetailWidget extends StatefulWidget {
  CareerDetailWidget({Key key, this.careerObject}) : super(key: key);
  final CareerObject careerObject;

  @override
  _CareerDetailWidgetState createState() => _CareerDetailWidgetState();
}

class _CareerDetailWidgetState extends State<CareerDetailWidget> {
  GlobalKey favButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                CareerDetailHeaderWidget(
                  careerObject: this.widget.careerObject,
                  favButtonKey: favButtonKey,
                ),
                SliverToBoxAdapter(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '${this.widget.careerObject.description}',
                          style: GoogleFonts.robotoSlab(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 36),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Image.asset(
                          'assets/illustrations/eastwood-school-bag.png'),
                    ),
                    Divider(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Text(
                        'Các trường có thể bạn quan tâm',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: CareerPlannerTheme.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    UniversityBubblesWidget(
                        stream: constants.database
                            .reference()
                            .child('university_list')
                            .orderByChild("career_group")
                            .equalTo(this.widget.careerObject.careerGroup)
                            .limitToFirst(6)
                            .onValue),
                    Divider(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Text(
                        'Sự kiện hấp dẫn dành cho bạn',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: CareerPlannerTheme.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    EventCarouselWidget(
                        screenSize: MediaQuery.of(context).size,
                        stream: constants.database
                            .reference()
                            .child('events')
                            .orderByChild("career_group")
                            .equalTo(this.widget.careerObject.careerGroup)
                            .onValue),
                    Divider(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Text(
                        'Tin tức hữu ích',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: CareerPlannerTheme.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    NewsCarouselWidget(
                        screenSize: MediaQuery.of(context).size,
                        stream: constants.database
                            .reference()
                            .child('news')
                            .orderByChild("career_group")
                            .equalTo(this.widget.careerObject.careerGroup)
                            .onValue),
                    Divider(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Text(
                        'Ngành nghề khác liên quan',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: CareerPlannerTheme.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    CareerListCarousel(
                        screenSize: MediaQuery.of(context).size,
                        stream: constants.database
                            .reference()
                            .child('career_list')
                            .orderByChild('career_group')
                            .equalTo(this.widget.careerObject.careerGroup)
                            .onValue),
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
