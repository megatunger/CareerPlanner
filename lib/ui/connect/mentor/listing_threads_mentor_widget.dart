import 'package:careerplanner/bloc/thread/thread_bloc.dart';
import 'package:careerplanner/model/account/mentor_object.dart';
import 'package:careerplanner/model/thread/create_thread_params.dart';
import 'package:careerplanner/model/thread/thread_object.dart';
import 'package:careerplanner/ui/connect/thread/thread_card.dart';
import 'package:careerplanner/ui/home/home_shortcuts_widget.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListingThreadsMentorWidget extends StatefulWidget {
  ListingThreadsMentorWidget({Key key, this.mentor}) : super(key: key);
  final MentorObject mentor;
  @override
  _ListingThreadsMentorWidgetState createState() =>
      _ListingThreadsMentorWidgetState();
}

class _ListingThreadsMentorWidgetState
    extends State<ListingThreadsMentorWidget> {
  @override
  void initState() {
    threadBloc.index(this.widget.mentor.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: HomeShortcutWidget(
                title: 'Tạo chủ đề',
                icon: Icons.edit,
                color: CareerPlannerTheme.primaryColor,
                callback: () {
                  Navigator.pushNamed(context, Routes.connectNewThreadRoute,
                      arguments: CreateThreadParams(
                          mentorUid: this.widget.mentor.uid));
                }),
          ),
          StreamBuilder(
            stream: threadBloc.index(this.widget.mentor.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final threads = snapshot.data.docs
                    .map((e) => ThreadObject.fromJson(e.data()))
                    .toList();
                List<Widget> listCards = [];
                threads.forEach((element) {
                  listCards.add(ThreadCard(
                      thread: element, mentorUid: this.widget.mentor.uid));
                  listCards.add(SizedBox(height: 16));
                });
                return Column(children: listCards);
              }
              return Container();
            },
          )
        ]);
  }
}
