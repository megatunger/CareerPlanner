import 'package:careerplanner/model/enroll/career/career_object.dart';
import 'package:careerplanner/model/enroll/university/university_object.dart';
import 'package:careerplanner/model/news/article_object.dart';
import 'package:careerplanner/ui/about_us/about_us_widget.dart';
import 'package:careerplanner/ui/account/authentication_redirect.dart';
import 'package:careerplanner/ui/account/edit_account_information.dart';
import 'package:careerplanner/ui/account/login/phone_login_widget.dart';
import 'package:careerplanner/ui/enroll/career/career_detail_widget.dart';
import 'package:careerplanner/ui/enroll/career_list/listing_all_career.dart';
import 'package:careerplanner/ui/enroll/university/university_detail.dart';
import 'package:careerplanner/ui/enroll/university_list/listing_all_university.dart';
import 'package:careerplanner/ui/event/event_list_widget.dart';
import 'package:careerplanner/ui/layout/layout_widget.dart';
import 'package:careerplanner/ui/news/news_detail/news_detail_widget.dart';
import 'package:careerplanner/ui/news/news_list_widget.dart';
import 'package:careerplanner/ui/quiz/question_showing_widget.dart';
import 'package:careerplanner/ui/quiz/quiz_career_widget.dart';
import 'package:careerplanner/ui/quiz/quiz_results.dart';
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
      case '/university/detail':
        var _university = settings.arguments as UniversityObject;
        return MaterialPageRoute(
            builder: (_) => UniversityDetail(
                  universityObject: _university,
                ));
      case '/university/all':
        return MaterialPageRoute(builder: (_) => ListingAllUniversity());
      case '/quiz/career':
        return MaterialPageRoute(builder: (_) => QuizCareerWidget());
      case '/quiz/questions':
        return MaterialPageRoute(builder: (_) => QuestionShowingWidget());
      case '/quiz/results':
        return MaterialPageRoute(builder: (_) => QuizResults());
      case '/events/all':
        return MaterialPageRoute(builder: (_) => EventListWidget());
      case '/news/all':
        return MaterialPageRoute(builder: (_) => NewsListWidget());
      case '/news/detail':
        var _article = settings.arguments as ArticleObject;
        return MaterialPageRoute(
            builder: (_) => NewsDetailWidget(article: _article));
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
  static const String universityDetailRoute = '/university/detail';
  static const String universityAllRoute = '/university/all';
  static const String quizCareerRoute = '/quiz/career';
  static const String quizQuestionsRoute = '/quiz/questions';
  static const String quizResultsRoute = '/quiz/results';
  static const String eventsListRoute = '/events/all';
  static const String newsListRoute = '/news/all';
  static const String newsDetailRoute = '/news/detail';
}
