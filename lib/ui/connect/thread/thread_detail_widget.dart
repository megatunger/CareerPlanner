import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/bloc/thread/thread_bloc.dart';
import 'package:careerplanner/model/thread/create_thread_params.dart';
import 'package:careerplanner/model/thread/thread_object.dart';
import 'package:careerplanner/ui/connect/thread/create_comment.dart';
import 'package:careerplanner/ui/connect/thread/thread_comments_listing.dart';
import 'package:careerplanner/ui/connect/thread/thread_images_carousel.dart';
import 'package:careerplanner/ui/home/home_shortcuts_widget.dart';
import 'package:careerplanner/ui/shared/loading_widget.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ThreadDetailWidget extends StatefulWidget {
  ThreadDetailWidget({Key key, this.threadId, this.uid}) : super(key: key);
  final String threadId;
  final String uid;
  @override
  _ThreadDetailWidgetState createState() => _ThreadDetailWidgetState();
}

class _ThreadDetailWidgetState extends State<ThreadDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          threadBloc.show(uid: this.widget.uid, threadId: this.widget.threadId),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          final thread = ThreadObject.fromJson(snapshot.data.data());
          return Scaffold(
              backgroundColor: CareerPlannerTheme.neutralBackground,
              appBar: AppBar(
                backgroundColor: CareerPlannerTheme.neutralBackground,
                iconTheme: IconThemeData(color: Colors.black),
                elevation: 0,
                actions: [
                  if (accountBloc.currentUser().uid == thread.uid)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FlatButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.connectNewThreadRoute,
                                arguments:
                                    CreateThreadParams(createdThread: thread));
                          },
                          icon: Icon(Icons.edit),
                          label: Text('Sửa',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(fontWeight: FontWeight.bold))),
                    )
                ],
              ),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.08), BlendMode.dstIn),
                    image: AssetImage("assets/illustrations/4086124.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView(children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${thread.title}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            )),
                      ],
                    ),
                  ),
                  if (thread.imagesObject.isNotEmpty)
                    ThreadImagesCarousel(
                        images: thread.imagesObject,
                        screenSize: MediaQuery.of(context).size),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('${thread.description}',
                        style: TextStyle(fontSize: 16)),
                  ),
                  HomeShortcutWidget(
                      title: 'Trả lời chủ đề này',
                      icon: Icons.edit,
                      color: CareerPlannerTheme.thirdColor,
                      callback: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.0)),
                            ),
                            builder: (BuildContext context) {
                              return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: CreateComment(thread: thread));
                            });
                      }),
                  ThreadCommentsListing(thread: thread)
                ]),
              ));
        }
        return LoadingWidget();
      },
    );
  }
}
