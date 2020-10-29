import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/model/enroll/career/career_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CareerBloc {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> updateFavouriteCareer(
      CareerObject career, bool favourite) async {
    Map<String, dynamic> data = {
      "career_id": "${career.id}",
      "career_name": "${career.careerName}",
      "favourite": favourite,
      "career_group": "${career.careerGroup}",
      "timestamp": DateTime.now().millisecondsSinceEpoch
    };
    _fireStore
        .collection("users")
        .doc(accountBloc.currentUser().uid)
        .collection("user_careers")
        .doc("${career.id}")
        .set(data, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> didFavouriteCareer(CareerObject career) {
    return _fireStore
        .collection("users")
        .doc(accountBloc.currentUser().uid)
        .collection('user_careers')
        .where('career_id', isEqualTo: "${career.id}")
        .snapshots();
  }
}

final careerBloc = CareerBloc();
