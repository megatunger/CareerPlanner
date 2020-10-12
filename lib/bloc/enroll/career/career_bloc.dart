import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CareerBloc {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> updateFavouriteCareer(String careerCode, bool favourite) async {
    Map<String, dynamic> data = {
      "career_code": "$careerCode",
      "favourite": favourite,
      "timestamp": DateTime.now().millisecondsSinceEpoch
    };
    _fireStore
        .collection("users")
        .doc(accountBloc.currentUser().uid)
        .collection("user_careers")
        .doc(careerCode)
        .set(data, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> didFavouriteCareer(String careerCode) {
    return _fireStore
        .collection("users")
        .doc(accountBloc.currentUser().uid)
        .collection('user_careers')
        .where('career_code', isEqualTo: careerCode)
        .snapshots();
  }
}

final careerBloc = CareerBloc();
