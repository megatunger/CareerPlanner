import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/ui/account/existed_mentor_account.dart';
import 'package:careerplanner/ui/account/welcome_new_account.dart';
import 'package:careerplanner/ui/shared/loading_widget.dart';
import 'package:flutter/material.dart';

import 'existed_student_account.dart';

class AuthenticationRedirect extends StatefulWidget {
  AuthenticationRedirect({Key key}) : super(key: key);

  @override
  _AuthenticationRedirectState createState() => _AuthenticationRedirectState();
}

class _AuthenticationRedirectState extends State<AuthenticationRedirect> {
  @override
  void initState() {
    accountBloc.checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: StreamBuilder<String>(
        stream: accountBloc.accountRedirectSubject.stream,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'new_account') {
              return WelcomeNewAccount();
            }
            if (snapshot.data == 'existed_account') {
              if (accountBloc.accountSubject.value.accountType == 'student') {
                return ExistedStudentAccount();
              }
              if (accountBloc.accountSubject.value.accountType == 'mentor') {
                return ExistedMentorAccount();
              }
              return Container();
            }
            return Text('Unhandled message: ${snapshot.data}');
          }
          return LoadingWidget();
        },
      ),
    ));
  }
}
