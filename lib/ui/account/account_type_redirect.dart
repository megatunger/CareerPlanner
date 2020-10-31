import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/model/account/account_object.dart';
import 'package:careerplanner/ui/account/existed_mentor_account.dart';
import 'package:careerplanner/ui/account/existed_student_account.dart';
import 'package:careerplanner/ui/shared/loading_widget.dart';
import 'package:flutter/material.dart';

class AccountTypeRedirect extends StatefulWidget {
  AccountTypeRedirect({Key key}) : super(key: key);

  @override
  _AccountTypeRedirectState createState() => _AccountTypeRedirectState();
}

class _AccountTypeRedirectState extends State<AccountTypeRedirect> {
  @override
  void initState() {
    accountBloc.getCurrentInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: accountBloc.accountSubject.stream,
      builder: (BuildContext context, AsyncSnapshot<AccountObject> snapshot) {
        if (snapshot.hasData) {
          final account = snapshot.data;
          if (accountBloc.accountSubject.value.accountType == 'student') {
            return ExistedStudentAccount();
          }
          if (accountBloc.accountSubject.value.accountType == 'mentor') {
            return ExistedMentorAccount();
          }
        }
        return LoadingWidget();
      },
    );
  }
}
