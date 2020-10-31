import 'package:careerplanner/bloc/account/account_bloc.dart';
import 'package:careerplanner/model/thread/thread_object.dart';
import 'package:careerplanner/ui/connect/thread/thread_images_carousel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ThreadCommentsListing extends StatefulWidget {
  ThreadCommentsListing({Key key, this.thread}) : super(key: key);
  final ThreadObject thread;
  @override
  _ThreadCommentsListingState createState() => _ThreadCommentsListingState();
}

class _ThreadCommentsListingState extends State<ThreadCommentsListing> {
  @override
  Widget build(BuildContext context) {
    if (this.widget.thread.commentObject == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: this.widget.thread.commentObject.map((e) {
          return Card(
              semanticContainer: true,
              color: (e.uid == accountBloc.currentUser().uid)
                  ? Colors.green.shade100
                  : Colors.blue.shade100,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('${e.body}',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    ),
                    if (e.imagesObject.isNotEmpty)
                      Column(
                        children: [
                          SizedBox(height: 8),
                          ThreadImagesCarousel(
                              images: e.imagesObject,
                              screenSize: MediaQuery.of(context).size),
                        ],
                      ),
                    SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                          '${DateFormat.yMMMMEEEEd().add_jms().format(DateTime.fromMillisecondsSinceEpoch(e.timestamp))}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption),
                    )
                  ],
                ),
              ));
        }).toList(),
      ),
    );
  }
}
