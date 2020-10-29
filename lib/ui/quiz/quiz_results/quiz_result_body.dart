import 'package:careerplanner/bloc/quiz/quiz_bloc.dart';
import 'package:careerplanner/model/enroll/career/career_group_object.dart';
import 'package:careerplanner/ui/enroll/career_list/career_list_carousel.dart';
import 'package:careerplanner/ui/enroll/university_list/university_bubbles_widget.dart';
import 'package:careerplanner/ui/event/event_carousel_widget.dart';
import 'package:careerplanner/ui/news/news_carousel_widget.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinycolor/tinycolor.dart';

class QuizResultBody extends StatefulWidget {
  QuizResultBody({Key key}) : super(key: key);

  @override
  _QuizResultBodyState createState() => _QuizResultBodyState();
}

class _QuizResultBodyState extends State<QuizResultBody> {
  @override
  void initState() {
    quizBloc.count();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CareerGroupObject>(
      stream: quizBloc.careerGroupSubject.stream,
      builder: (context, AsyncSnapshot<CareerGroupObject> _snapshot) {
        if (_snapshot.hasData) {
          final group = _snapshot.data;
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Bạn thuộc nhóm',
                            style: GoogleFonts.robotoSlabTextTheme()
                                .headline5
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 24),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${group.groupTitle}',
                            style: GoogleFonts.robotoSlabTextTheme()
                                .headline5
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36,
                                    color: CareerPlannerTheme.thirdColor),
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: double.infinity,
                            child: Card(
                              semanticContainer: true,
                              color:
                                  TinyColor(CareerPlannerTheme.secondaryColor)
                                      .darken(20)
                                      .color,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      TinyColor(
                                              CareerPlannerTheme.secondaryColor)
                                          .color
                                          .withOpacity(0.4),
                                      BlendMode.srcOver),
                                  child: Image.network(group.image,
                                      fit: BoxFit.cover)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(group.groupDescription,
                                style: GoogleFonts.robotoSlabTextTheme()
                                    .caption
                                    .copyWith(fontSize: 16),
                                textAlign: TextAlign.justify),
                          ),
                        ])),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Text(
                        'Sự kiện hấp dẫn cho bạn',
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
                            .equalTo(group.groupCode)
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
                            .equalTo(group.groupCode)
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
                            .equalTo(group.groupCode)
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
                            .equalTo(group.groupCode)
                            .onValue),
                  ],
                )
              ]);
        } else {
          return Center(
              child: Align(
                  alignment: Alignment.center,
                  child: LinearProgressIndicator()));
        }
      },
    );
  }
}
