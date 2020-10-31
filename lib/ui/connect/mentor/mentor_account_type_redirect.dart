import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/model/account/account_object.dart';
import 'package:careerplanner/ui/connect/mentor/connect_mentor_widget.dart';
import 'package:careerplanner/ui/connect/student/connect_student_widget.dart';
import 'package:careerplanner/ui/shared/loading_widget.dart';
import 'package:careerplanner/ui/shared/login_required_feature_widget.dart';
import 'package:flutter/material.dart';

class MentorAccountTypeRedirect extends StatefulWidget {
  MentorAccountTypeRedirect({Key key}) : super(key: key);

  @override
  _MentorAccountTypeRedirectState createState() =>
      _MentorAccountTypeRedirectState();
}

class _MentorAccountTypeRedirectState extends State<MentorAccountTypeRedirect> {
  @override
  void initState() {
    accountBloc.checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: accountBloc.accountRedirectSubject.stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == 'new_account') {
            return LoginRequiredFeatureWidget();
          }
          if (snapshot.data == 'existed_account') {
            accountBloc.getCurrentInformation();
            return StreamBuilder(
              stream: accountBloc.accountSubject.stream,
              builder: (BuildContext context,
                  AsyncSnapshot<AccountObject> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.accountType == 'mentor') {
                    return ConnectMentorWidget();
                  } else {
                    return ConnectStudentWidget();
                  }
                }
                return LoadingWidget();
              },
            );
          }
          return Text('Unhandled message: ${snapshot.data}');
        }
        return LoadingWidget();
      },
    );
  }
}
