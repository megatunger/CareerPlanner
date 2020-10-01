import 'package:careerplanner/ui/account/account_widget.dart';
import 'package:careerplanner/ui/account/login/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationRedirect extends StatefulWidget {
  AuthenticationRedirect({Key key}) : super(key: key);

  @override
  _AuthenticationRedirectState createState() => _AuthenticationRedirectState();
}

class _AuthenticationRedirectState extends State<AuthenticationRedirect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tài Khoản"),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snap) {
            Widget _widget;
            if (snap.connectionState == ConnectionState.active) {
              if (snap.data == null) {
                _widget = LoginWidget();
              } else {
                return AccountWidget();
              }
            } else {
              _widget = CircularProgressIndicator();
            }
            return AnimatedSwitcher(
                duration: const Duration(milliseconds: 750),
                switchInCurve: Curves.easeInOutQuart,
                switchOutCurve: Curves.easeInOutQuart,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(child: child, scale: animation);
                },
                child: _widget);
          },
        ));
  }
}
