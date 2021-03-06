import 'package:careerplanner/model/enroll/career/career_object.dart';
import 'package:careerplanner/model/enroll/university/university_object.dart';
import 'package:careerplanner/model/event/event_object.dart';
import 'package:careerplanner/model/news/article_object.dart';
import 'package:careerplanner/model/thread/create_thread_params.dart';
import 'package:careerplanner/model/thread/thread_detail_params.dart';
import 'package:careerplanner/ui/about_us/about_us_widget.dart';
import 'package:careerplanner/ui/account/account_type/register_form_widget.dart';
import 'package:careerplanner/ui/account/authentication_redirect.dart';
import 'package:careerplanner/ui/account/login_by_phone.dart';
import 'package:careerplanner/ui/connect/mentor/connect_mentor_widget.dart';
import 'package:careerplanner/ui/connect/thread/create_thread.dart';
import 'package:careerplanner/ui/connect/thread/thread_detail_widget.dart';
import 'package:careerplanner/ui/enroll/career/career_detail_widget.dart';
import 'package:careerplanner/ui/enroll/career_list/listing_all_career.dart';
import 'package:careerplanner/ui/enroll/university/university_detail.dart';
import 'package:careerplanner/ui/enroll/university_list/listing_all_university.dart';
import 'package:careerplanner/ui/event/event_detail.dart';
import 'package:careerplanner/ui/event/event_list_widget.dart';
import 'package:careerplanner/ui/layout/layout_widget.dart';
import 'package:careerplanner/ui/news/news_detail/news_detail_widget.dart';
import 'package:careerplanner/ui/news/news_list_widget.dart';
import 'package:careerplanner/ui/quiz/question_showing_widget.dart';
import 'package:careerplanner/ui/quiz/quiz_career_widget.dart';
import 'package:careerplanner/ui/quiz/quiz_results.dart';
import 'package:careerplanner/ui/rewards/rewards_widget.dart';
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
      case '/authenticate/login/phone':
        return MaterialPageRoute(builder: (_) => LoginByPhone());
      case '/authenticate/register':
        var _accountType = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => RegisterFormWidget(accountType: _accountType));
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
      case '/events/detail':
        var _event = settings.arguments as EventObject;
        return MaterialPageRoute(builder: (_) => EventDetail(event: _event));
      case '/news/all':
        return MaterialPageRoute(builder: (_) => NewsListWidget());
      case '/news/detail':
        var _article = settings.arguments as ArticleObject;
        return MaterialPageRoute(
            builder: (_) => NewsDetailWidget(article: _article));
      case '/rewards':
        return MaterialPageRoute(builder: (_) => RewardsWidget());
      case '/connect/mentor':
        return MaterialPageRoute(builder: (_) => ConnectMentorWidget());
      case '/connect/thread/new':
        var _args = settings.arguments as CreateThreadParams;
        return MaterialPageRoute(
            builder: (_) => CreateThread(
                createdThread: _args.createdThread,
                mentorUid: _args.mentorUid));
      case '/connect/thread/detail':
        var _args = settings.arguments as ThreadDetailParams;
        return MaterialPageRoute(
            builder: (_) =>
                ThreadDetailWidget(threadId: _args.threadId, uid: _args.uid));
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
  static const String loginByPhoneRoute = '/authenticate/login/phone';
  static const String registerRoute = '/authenticate/register';
  static const String aboutUsRoute = '/aboutUs';
  static const String careerDetailRoute = '/career/detail';
  static const String careerAllRoute = '/career/all';
  static const String universityDetailRoute = '/university/detail';
  static const String universityAllRoute = '/university/all';
  static const String quizCareerRoute = '/quiz/career';
  static const String quizQuestionsRoute = '/quiz/questions';
  static const String quizResultsRoute = '/quiz/results';
  static const String eventsListRoute = '/events/all';
  static const String eventsDetailRoute = '/events/detail';
  static const String newsListRoute = '/news/all';
  static const String newsDetailRoute = '/news/detail';
  static const String rewardsRoute = '/rewards';
  static const String connectMentorRoute = '/connect/mentor';
  static const String connectNewThreadRoute = '/connect/thread/new';
  static const String connectDetailThreadRoute = '/connect/thread/detail';
}
