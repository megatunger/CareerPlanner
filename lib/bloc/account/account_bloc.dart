import 'package:careerplanner/model/account/account_object.dart';
import 'package:careerplanner/model/account/mentor_object.dart';
import 'package:careerplanner/ui/account/phone_verify/phone_verify_widget.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountBloc {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final BehaviorSubject<String> _accountRedirectSubject =
      BehaviorSubject<String>();
  final BehaviorSubject<AccountObject> _accountSubject =
      BehaviorSubject<AccountObject>();
  final BehaviorSubject<MentorObject> _mentorAccountSubject =
      BehaviorSubject<MentorObject>();
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  createNewCollection() async {
    await _fireStore.collection("users").doc(currentUser().uid).set({});
  }

  checkUser() async {
    final _isNewAccount = await isNewAccount();
    if (_isNewAccount) {
      _accountRedirectSubject.sink.add('new_account');
    } else {
      _accountRedirectSubject.sink.add('existed_account');
    }
  }

  checkMentor(String uid) async {
    final _realtimeDB =
        await constants.database.reference().child('mentors').child(uid).once();
    final mentor =
        MentorObject.fromJson(Map<String, dynamic>.from(_realtimeDB.value));
    print(mentor.toJson());
    _mentorAccountSubject.sink.add(mentor);
  }

  Future<void> updateInformation(
      {AccountObject account, GlobalKey<ScaffoldState> scaffoldKey}) async {
    _auth.currentUser.updateEmail(account.email);
    if (account.phone != null) {
      print('phone is available');
      showDialog<void>(
        context: scaffoldKey.currentContext,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return PhoneVerifyWidget(account: account);
        },
      );
      return;
    } else {
      await mirrorToFirestore(account: account);
      checkUser();
      return;
    }
  }

  mirrorToFirestore({AccountObject account}) async {
    await _fireStore
        .collection("users")
        .doc(currentUser().uid)
        .update(account.toJson());
    if (account.accountType == 'mentor') {
      final _realtimeDB = await constants.database.reference().child('mentors');
      await _realtimeDB.set({account.uid: account.name});
    }
    getCurrentInformation();
  }

  getCurrentInformation() async {
    final _isNewAccount = await isNewAccount();
    if (_isNewAccount) {
      _accountSubject.sink.add(AccountObject(walletBalance: 50));
    } else {
      final dbRef =
          await _fireStore.collection("users").doc(currentUser().uid).get();
      final _account = AccountObject.fromJson(dbRef.data());
      _accountSubject.sink.add(_account);
    }
  }

  logout() async {
    _auth.signOut();
    SharedPreferences.getInstance().then((value) {
      value.clear();
    });
  }

  dispose() {
    _accountRedirectSubject.close();
    _accountSubject.close();
    _mentorAccountSubject.close();
  }

  User currentUser() {
    return _auth.currentUser;
  }

  Future<bool> isNewAccount() async {
    final dbRef =
        await _fireStore.collection("users").doc(currentUser().uid).get();
    if (dbRef.data().isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  BehaviorSubject<String> get accountRedirectSubject => _accountRedirectSubject;
  BehaviorSubject<AccountObject> get accountSubject => _accountSubject;
  BehaviorSubject<MentorObject> get mentorAccountSubject =>
      _mentorAccountSubject;
}

final accountBloc = AccountBloc();
