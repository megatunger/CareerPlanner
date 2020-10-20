import 'package:careerplanner/model/quiz/question_object.dart';
import 'package:firebase_database/firebase_database.dart';

class QuestionsData {
  List<QuestionObject> questions;

  QuestionsData({this.questions});

  factory QuestionsData.fromSnapshot(DataSnapshot snapshot) {
    List<QuestionObject> data = [];
    List<dynamic> values = snapshot.value;
    values.forEach((element) {
      if (element != null) {
        final questionObject =
            QuestionObject.fromJson(Map<String, dynamic>.from(element));
        data.add(questionObject);
      }
    });
    data.shuffle();
    return QuestionsData(questions: data);
  }
}
