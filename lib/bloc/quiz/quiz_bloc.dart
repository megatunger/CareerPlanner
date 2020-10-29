import 'dart:collection';

import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/model/enroll/career/career_group_data.dart';
import 'package:careerplanner/model/enroll/career/career_group_object.dart';
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
  final BehaviorSubject<CareerGroupObject> _careerGroupSubject =
      BehaviorSubject<CareerGroupObject>();
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

  count() async {
    HashMap<String, int> map = HashMap<String, int>();
    final dbRef =
        await constants.database.reference().child('career_group').once();
    final careerGroupData = CareerGroupData.fromSnapshot(dbRef);
    careerGroupData.careerGroups.forEach((element) {
      map.putIfAbsent(element.groupCode, () => 0);
    });
    final quizAnsweredData = await _fireStore
        .collection("users")
        .doc(accountBloc.currentUser().uid)
        .collection('quiz_answers')
        .get();
    quizAnsweredData.docs.forEach((element) {
      map.update(
          element["career_group"], (value) => value + element["stars"].toInt());
    });
    final careerFavouriteData = await _fireStore
        .collection("users")
        .doc(accountBloc.currentUser().uid)
        .collection('user_careers')
        .get();
    careerFavouriteData.docs.forEach((element) {
      map.update(element["career_group"], (value) => value + 5);
    });
    final sorted =
        SplayTreeMap.from(map, (key1, key2) => map[key1].compareTo(map[key2]));
    print(sorted);
    final lastResult = careerGroupData.careerGroups
        .firstWhere((element) => element.groupCode == sorted.lastKey());
    _careerGroupSubject.sink.add(lastResult);
  }

  dispose() {
    _questionSubject.close();
    _careerGroupSubject.close();
  }

  BehaviorSubject<QuestionObject> get questionSubject => _questionSubject;
  BehaviorSubject<CareerGroupObject> get careerGroupSubject =>
      _careerGroupSubject;
}

final quizBloc = QuizBloc();
