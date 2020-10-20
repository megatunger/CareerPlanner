import 'package:careerplanner/bloc/quiz/quiz_bloc.dart';
import 'package:careerplanner/model/quiz/question_object.dart';
import 'package:careerplanner/ui/quiz/question/out_of_questions_widget.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class QuestionWidget extends StatefulWidget {
  QuestionWidget({Key key, this.data}) : super(key: key);
  final QuestionObject data;
  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.data.question == Constants.outOfQuestions) {
      return OutOfQuestionsWidget();
    }
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.help,
              size: 96,
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('${this.widget.data.question}',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 56),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  RatingBar(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      quizBloc.updateAnswer(this.widget.data, rating);
                      Navigator.pushReplacementNamed(
                          context, Routes.quizQuestionsRoute);
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                      '0 điểm: Bạn thấy nhận định hoàn toàn không đúng\n1 điểm: Nhận định đúng trong một số trường hợp\n2 điểm: Nhận định đúng 50%\n3 điểm: Nhận định đúng khoảng 80 – 90%\n4 điểm: Nhận định hoàn toàn đúng',
                      style: Theme.of(context).textTheme.caption)
                ],
              ),
            ),
          ]),
    );
  }
}
