import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/model/account/mentor_object.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MentorInformationWidget extends StatefulWidget {
  MentorInformationWidget({Key key, this.mentor}) : super(key: key);
  final MentorObject mentor;
  @override
  _MentorInformationWidgetState createState() =>
      _MentorInformationWidgetState();
}

class _MentorInformationWidgetState extends State<MentorInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
              semanticContainer: true,
              color: CareerPlannerTheme.neutralBackground,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 48,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Chuyên gia',
                                style: TextStyle(color: Colors.black54)),
                            SizedBox(height: 4),
                            Text('${this.widget.mentor.mentorName}',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700)),
                            SizedBox(height: 4),
                            Text(
                                '${accountBloc.mentorAccountSubject.value.mentorSchool}',
                                style: TextStyle(color: Colors.black54)),
                            SizedBox(height: 4),
                          ],
                        ),
                        trailing: CircleAvatar(
                          radius: 32.0,
                          backgroundImage:
                              NetworkImage(this.widget.mentor.mentorImage),
                          backgroundColor: CareerPlannerTheme.primaryColor,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 24),
                      child: Text(
                        this.widget.mentor.mentorDescription,
                        style: GoogleFonts.robotoSlabTextTheme()
                            .caption
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ))
        ]);
  }
}
