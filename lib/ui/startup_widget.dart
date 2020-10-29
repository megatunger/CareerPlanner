import 'package:careerplanner/ui/splash/animated_splash.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            SharedPreferences.getInstance().then((value) {
              if (value.getBool(Constants.shownOnboardingScreen) == true) {
                Navigator.pushReplacementNamed(context, Routes.homeRoute);
              } else {
                Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
              }
            });
          }
          loaded = true;
        }
        return AnimatedSplash(message: '', loading: true);
      },
    );
  }
}
