import 'package:careerplanner/model/event/event_object.dart';
import 'package:careerplanner/ui/enroll/career_list/career_list_carousel.dart';
import 'package:careerplanner/ui/enroll/university_list/university_bubbles_widget.dart';
import 'package:careerplanner/ui/event/event_carousel_widget.dart';
import 'package:careerplanner/ui/event/event_detail/event_detail_card_info.dart';
import 'package:careerplanner/ui/news/news_carousel_widget.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'event_detail/register_event_button.dart';

class EventDetail extends StatefulWidget {
  EventDetail({Key key, this.event}) : super(key: key);
  final EventObject event;
  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: CareerPlannerTheme.neutralBackground,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          this.widget.event.eventName,
                          style: GoogleFonts.robotoSlabTextTheme()
                              .headline5
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 36),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        this.widget.event.description,
                        style: GoogleFonts.robotoSlabTextTheme()
                            .caption
                            .copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      EventDetailCardInfo(size: size, event: this.widget.event),
                      RegisterEventButton(
                        event: this.widget.event,
                        scaffoldKey: _scaffoldKey,
                      ),
                    ],
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: Text(
                      'Sự kiện hấp dẫn khác',
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
                          .equalTo(this.widget.event.careerGroup)
                          .onValue),
                  Divider(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: Text(
                      'Ngành nghề liên quan',
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
                          .equalTo(this.widget.event.careerGroup)
                          .onValue),
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
                          .equalTo(this.widget.event.careerGroup)
                          .limitToFirst(6)
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
                          .equalTo(this.widget.event.careerGroup)
                          .onValue),
                ],
              )
            ],
          )
        ]));
  }
}
