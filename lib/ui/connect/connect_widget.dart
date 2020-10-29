import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/model/account/account_object.dart';
import 'package:careerplanner/ui/connect/mentor/connect_mentor_widget.dart';
import 'package:careerplanner/ui/connect/student/connect_student_widget.dart';
import 'package:careerplanner/ui/shared/loading_widget.dart';
import 'package:flutter/material.dart';

class ConnectWidget extends StatefulWidget {
  ConnectWidget({Key key}) : super(key: key);

  @override
  _ConnectWidgetState createState() => _ConnectWidgetState();
}

class _ConnectWidgetState extends State<ConnectWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter:
              ColorFilter.mode(Colors.white.withOpacity(0.08), BlendMode.dstIn),
          image: AssetImage("assets/illustrations/4086124.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: StreamBuilder(
        stream: accountBloc.accountSubject.stream,
        builder: (BuildContext context, AsyncSnapshot<AccountObject> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.accountType == 'student') {
              return ConnectStudentWidget();
            }
            if (snapshot.data.accountType == 'mentor') {
              return ConnectMentorWidget();
            }
            return Text('Unrecognized account type!');
          }
          return LoadingWidget();
        },
      ),
    ));
  }
}
