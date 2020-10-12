import 'package:careerplanner/model/enroll/CareerObject.dart';
import 'package:careerplanner/ui/about_us/about_us_widget.dart';
import 'package:careerplanner/ui/account/authentication_redirect.dart';
import 'package:careerplanner/ui/account/edit_account_information.dart';
import 'package:careerplanner/ui/account/login/phone_login_widget.dart';
import 'package:careerplanner/ui/enroll/career/career_detail_widget.dart';
import 'package:careerplanner/ui/enroll/career_list/listing_all_career.dart';
import 'package:careerplanner/ui/enroll/career_list/search_career.dart';
import 'package:careerplanner/ui/layout/layout_widget.dart';
import 'package:careerplanner/ui/splash/onboarding_widget.dart';
import 'package:careerplanner/ui/startup_widget.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/onBoarding':
        return MaterialPageRoute(builder: (_) => OnboardingWidget());
      case '/startup':
        return MaterialPageRoute(builder: (_) => StartupWidget());
      case '/':
        return MaterialPageRoute(builder: (_) => LayoutWidget());
      case '/authenticate':
        return MaterialPageRoute(builder: (_) => AuthenticationRedirect());
      case '/loginByPhone':
        return MaterialPageRoute(builder: (_) => PhoneLoginWidget());
      case '/editAccount':
        return MaterialPageRoute(builder: (_) => EditAccountInformation());
      case '/aboutUs':
        return MaterialPageRoute(builder: (_) => AboutUsWidget());
      case '/career/detail':
        var _career = settings.arguments as CareerObject;
        return MaterialPageRoute(
            builder: (_) => CareerDetailWidget(careerObject: _career));
      case '/career/all':
        return MaterialPageRoute(builder: (_) => ListingAllCareer());
      case '/career/search':
        return MaterialPageRoute(builder: (_) => SearchCareer());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

class Routes {
  static const String startupRoute = '/startup';
  static const String onBoardingRoute = '/onBoarding';
  static const String homeRoute = '/';
  static const String authenticateRoute = '/authenticate';
  static const String phoneLoginRoute = '/loginByPhone';
  static const String editAccountRoute = '/editAccount';
  static const String aboutUsRoute = '/aboutUs';
  static const String careerDetailRoute = '/career/detail';
  static const String careerAllRoute = '/career/all';
  static const String searchCareerRoute = '/career/search';
}
