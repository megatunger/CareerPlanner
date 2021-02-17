import 'package:careerplanner/bloc/quiz/quiz_bloc.dart';
import 'package:careerplanner/model/quiz/question_object.dart';
import 'package:careerplanner/ui/quiz/quiz_results/quiz_result_body.dart';
import 'package:careerplanner/ui/quiz/quiz_results/quiz_result_did_not_finished.dart';
import 'package:careerplanner/ui/quiz/quiz_results/quiz_result_header.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:flutter/material.dart';

class QuizResults extends StatefulWidget {
  QuizResults({Key key}) : super(key: key);

  @override
  _QuizResultsState createState() => _QuizResultsState();
}

class _QuizResultsState extends State<QuizResults> {
  @override
  void initState() {
    quizBloc.getQuestion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.08), BlendMode.dstIn),
              image: AssetImage("assets/illustrations/4086124.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomScrollView(slivers: [
            QuizResultHeader(),
            SliverToBoxAdapter(
                child: StreamBuilder(
                    stream: quizBloc.questionSubject,
                    builder: (context, AsyncSnapshot<QuestionObject> snapshot) {
                      Widget _widget;
                      if (snapshot.hasData) {
                        if (snapshot.data.question ==
                            Constants.outOfQuestions) {
                          _widget = QuizResultBody();
                        } else {
                          _widget = QuizResultDidNotFinished();
                        }
                      } else {
                        _widget = CircularProgressIndicator();
                      }
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 450),
                        switchInCurve: Curves.easeInOutQuad,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) =>
                                ScaleTransition(child: child, scale: animation),
                        child: _widget,
                      );
                    })),
          ])),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
