import 'package:careerplanner/ui/splash/animated_splash.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class StartupWidget extends StatefulWidget {
  StartupWidget({Key key}) : super(key: key);

  @override
  _StartupWidgetState createState() => _StartupWidgetState();
}

class _StartupWidgetState extends State<StartupWidget> {
  bool loaded = false;

  @override
  void initState() {
    constants.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (loaded == false) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pushNamed(context, Routes.homeRoute);
            });
          }
          loaded = true;
        }
        return AnimatedSplash(message: '', loading: true);
      },
    );
  }
}
