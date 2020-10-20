import 'package:careerplanner/bloc/quiz/quiz_bloc.dart';
import 'package:careerplanner/model/quiz/question_object.dart';
import 'package:careerplanner/model/quiz/questions_data.dart';
import 'package:careerplanner/ui/quiz/question/question_widget.dart';
import 'package:flutter/material.dart';

class QuestionShowingWidget extends StatefulWidget {
  QuestionShowingWidget({Key key}) : super(key: key);
  @override
  _QuestionShowingWidgetState createState() => _QuestionShowingWidgetState();
}

class _QuestionShowingWidgetState extends State<QuestionShowingWidget> {
  QuestionsData data;

  @override
  void initState() {
    quizBloc.getQuestion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: StreamBuilder(
              stream: quizBloc.questionSubject,
              builder: (context, AsyncSnapshot<QuestionObject> snapshot) {
                Widget _widget;
                if (snapshot.hasData) {
                  _widget = QuestionWidget(data: snapshot.data);
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
              }),
        ));
  }
}
