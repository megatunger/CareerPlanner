import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/model/quiz/question_object.dart';
import 'package:careerplanner/model/quiz/questions_data.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

class QuizBloc {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final BehaviorSubject<QuestionObject> _questionSubject =
      BehaviorSubject<QuestionObject>();
  final DatabaseReference careerQuizRef =
      constants.database.reference().child('career_quiz');

  Future<void> updateAnswer(QuestionObject question, double stars) async {
    Map<String, dynamic> data = {
      "question_id": question.id,
      "career_group": "${question.group}",
      "stars": stars,
      "timestamp": DateTime.now().millisecondsSinceEpoch
    };
    _fireStore
        .collection("users")
        .doc(accountBloc.currentUser().uid)
        .collection("quiz_answers")
        .doc(question.id.toString())
        .set(data, SetOptions(merge: true));
  }

  getQuestion() async {
    QuestionsData data = await careerQuizRef
        .once()
        .then((value) => QuestionsData.fromSnapshot(value));
    final snapshot = await _fireStore
        .collection("users")
        .doc(accountBloc.currentUser().uid)
        .collection('quiz_answers')
        .snapshots()
        .first;
    snapshot.docs.forEach((element) {
      data.questions.removeWhere(
          (question) => question.id == element.data()["question_id"]);
    });
    print("Remaining: ${data.questions.length}");
    if (data.questions.length == 0) {
      _questionSubject.sink
          .add(QuestionObject(question: Constants.outOfQuestions));
    } else {
      _questionSubject.sink.add(data.questions.first);
    }
  }

  removeAllRated() async {
    _fireStore
        .collection("users")
        .doc(accountBloc.currentUser().uid)
        .collection('quiz_answers')
        .snapshots()
        .forEach((element) {
      element.docs.forEach((_element) async {
        await _element.reference.delete();
      });
    });
  }

  dispose() {
    _questionSubject.close();
  }

  BehaviorSubject<QuestionObject> get questionSubject => _questionSubject;
}

final quizBloc = QuizBloc();
