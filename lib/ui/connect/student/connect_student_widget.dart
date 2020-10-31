import 'package:careerplanner/model/account/mentors_data.dart';
import 'package:careerplanner/ui/connect/student/mentor_bubble.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ConnectStudentWidget extends StatefulWidget {
  ConnectStudentWidget({Key key}) : super(key: key);
  final DatabaseReference mentorsListRef =
      constants.database.reference().child('mentors');
  @override
  _ConnectStudentWidgetState createState() => _ConnectStudentWidgetState();
}

class _ConnectStudentWidgetState extends State<ConnectStudentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.08), BlendMode.dstIn),
            image: AssetImage("assets/illustrations/4086124.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Kết nối hướng nghiệp',
              style: Theme.of(context).textTheme.headline6.copyWith(
                  color: CareerPlannerTheme.thirdColor,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.left,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                    stream: this.widget.mentorsListRef.onValue,
                    builder: (context, AsyncSnapshot<Event> snapshot) {
                      if (snapshot.data != null) {
                        final mentorsData =
                            MentorsData.fromSnapshot(snapshot.data.snapshot);
                        return GridView.extent(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width *
                                    0.5, // maximum pixel width of a item
                            padding: const EdgeInsets.all(4.0),
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            children: _buildGridTileList(mentorsData));
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              )
            ],
          )
        ]));
  }

  List<Container> _buildGridTileList(MentorsData data) {
    return List<Container>.generate(
        data.mentors.length,
        (int index) => Container(
              child: MentorBubble(mentor: data.mentors[index]),
            ));
  }
}
