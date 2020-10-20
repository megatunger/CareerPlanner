import 'package:careerplanner/bloc/quiz/quiz_bloc.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';

class OutOfQuestionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Expanded(
              child: Image.asset('assets/illustrations/hugo-success-1.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Chúc mừng bạn đã hoàn thành bài trắc nghiệm!',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Bạn có thể xem kết quả phân tích ở dưới nhé. Nếu cảm thấy chưa chính xác bạn có thể làm lại bài trắc nghiệm',
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Column(children: [
                Container(
                    width: double.infinity,
                    height: 56,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            context, Routes.quizResultsRoute);
                      },
                      elevation: 0,
                      color: CareerPlannerTheme.thirdColor,
                      child: Text('Xem Kết Quả Phân Tích',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    )),
                SizedBox(height: 16),
                Container(
                    width: double.infinity,
                    height: 56,
                    child: RaisedButton(
                      onPressed: () async {
                        await quizBloc.removeAllRated();
                        final snackBar =
                            SnackBar(content: Text('Vui lòng chờ một lát...'));
                        Scaffold.of(context).showSnackBar(snackBar);

                        Future.delayed(Duration(seconds: 3), () {
                          Navigator.pushReplacementNamed(
                              context, Routes.quizQuestionsRoute);
                        });
                      },
                      elevation: 0,
                      color: Colors.white,
                      child: Text('Làm Lại Bài Trắc Nghiệm',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: CareerPlannerTheme.thirdColor,
                              )),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Colors.transparent)),
                    )),
              ]),
            )
          ])),
    ));
  }
}
