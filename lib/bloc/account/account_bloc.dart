import 'package:careerplanner/model/account/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountBloc {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  User currentUser() {
    return _auth.currentUser;
  }

  Future<bool> isNewUser(User user) async {
    DocumentSnapshot result =
        await _fireStore.collection("users").doc(user.uid).get();
    return result.exists ? false : true;
  }

  Future<void> insertUserToDatabase(User _user) async {
    final newAccount = Account(uid: _user.uid);
    _fireStore.collection("users").doc(newAccount.uid).set(newAccount.toJson());
  }

  Future<void> updateUserToDatabase(Account _account, {User user}) async {
    if (user != null) {
      user.updateEmail(_account.email);
      user.updateProfile(displayName: _account.name);
    }
    _fireStore.collection("users").doc(_account.uid).update(_account.toJson());
  }

  void logout() {
    _auth.signOut();
  }
}

final accountBloc = AccountBloc();
