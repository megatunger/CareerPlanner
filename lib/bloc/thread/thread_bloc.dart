import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/model/thread/thread_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ThreadBloc {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final BehaviorSubject<ThreadObject> _threadBloc =
      BehaviorSubject<ThreadObject>();

  Future<void> create(ThreadObject thread, String uid) async {
    thread.timestamp = DateTime.now().millisecondsSinceEpoch;
    await _fireStore
        .collection("users")
        .doc(uid)
        .collection("threads")
        .doc(thread.id)
        .set(thread.toJson());
  }

  Future<void> createComment(ThreadObject thread, CommentObject comment) async {
    comment.timestamp = DateTime.now().millisecondsSinceEpoch;
    if (thread.commentObject == null) {
      thread.commentObject = List<CommentObject>();
    }
    thread.commentObject.insert(0, comment);
    print(comment.toJson());
    await _fireStore
        .collection("users")
        .doc(accountBloc.currentUser().uid)
        .collection("threads")
        .doc(thread.id)
        .set(thread.toJson());
  }

  Stream<QuerySnapshot> index(String uid) {
    return _fireStore
        .collection("users")
        .doc(uid)
        .collection("threads")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot> show({String uid, String threadId}) {
    return _fireStore
        .collection("users")
        .doc(uid)
        .collection("threads")
        .doc(threadId)
        .snapshots();
  }

  edit() async {}

  destroy() async {}

  dispose() {
    _threadBloc.close();
  }

  BehaviorSubject<ThreadObject> get threadBloc => _threadBloc;
}

final threadBloc = ThreadBloc();
