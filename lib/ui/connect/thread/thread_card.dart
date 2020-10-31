import 'package:careerplanner/model/thread/thread_detail_params.dart';
import 'package:careerplanner/model/thread/thread_object.dart';
import 'package:careerplanner/util/router.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThreadCard extends StatefulWidget {
  ThreadCard({Key key, this.thread, this.mentorUid}) : super(key: key);
  final ThreadObject thread;
  final String mentorUid;
  @override
  _ThreadCardState createState() => _ThreadCardState();
}

class _ThreadCardState extends State<ThreadCard> {
  Color color;

  @override
  void initState() {
    color = (CareerPlannerTheme.randomColors.toList()..shuffle()).first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.connectDetailThreadRoute,
              arguments: ThreadDetailParams(threadId: this.widget.thread.id, uid: this.widget.mentorUid));
        },
        child: Card(
            semanticContainer: true,
            color: color,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 0,
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: ListTile(
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${this.widget.thread.title}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                  SizedBox(height: 4),
                                  Divider(),
                                  Text('${this.widget.thread.description}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black54)),
                                  SizedBox(height: 32),
                                  Text(
                                      '${DateFormat.yMMMMEEEEd().add_jms().format(DateTime.fromMillisecondsSinceEpoch(this.widget.thread.timestamp))}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.caption)
                                ],
                              ),
                            )),
                        Icon(Icons.arrow_forward_ios_rounded,
                            size: 32, color: Colors.black54)
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
