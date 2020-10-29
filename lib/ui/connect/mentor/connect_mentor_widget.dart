import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/model/account/mentor_object.dart';
import 'package:careerplanner/ui/connect/mentor/listing_threads_mentor_widget.dart';
import 'package:careerplanner/ui/connect/mentor/mentor_information_widget.dart';
import 'package:flutter/material.dart';

class ConnectMentorWidget extends StatefulWidget {
  ConnectMentorWidget({Key key}) : super(key: key);

  @override
  _ConnectMentorWidgetState createState() => _ConnectMentorWidgetState();
}

class _ConnectMentorWidgetState extends State<ConnectMentorWidget> {
  @override
  void initState() {
    accountBloc.checkMentor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: accountBloc.mentorAccountSubject.stream,
      builder: (BuildContext context, AsyncSnapshot<MentorObject> snapshot) {
        if (snapshot.hasData) {
          final mentor = snapshot.data;
          if (mentor.verify != 'verified') {
            return unverifiedAccountWidget();
          } else {
            return ListView(children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MentorInformationWidget(mentor: mentor),
                    SizedBox(height: 54),
                    ListingThreadsMentorWidget(mentor: mentor)
                  ],
                ),
              ),
            ]);
          }
          return Container();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget unverifiedAccountWidget() {
    return SafeArea(
        child: Center(
      child: Column(children: [
        Spacer(),
        Image.asset('assets/illustrations/hugo-list-is-empty.png'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
              'Tài khoản của bạn chưa được duyệt. Chúng tôi sẽ liên hệ xác minh trong thời gian sớm nhất.',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center),
        ),
        Spacer(),
      ]),
    ));
  }
}
