import 'package:auto_animated/auto_animated.dart';
import 'package:careerplanner/model/event/event_data.dart';
import 'package:careerplanner/ui/event/event_card.dart';
import 'package:careerplanner/ui/shared/loading_widget.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EventListWidget extends StatefulWidget {
  EventListWidget({Key key}) : super(key: key);
  final DatabaseReference articlesListRef =
      constants.database.reference().child('events');
  @override
  _EventListWidgetState createState() => _EventListWidgetState();
}

class _EventListWidgetState extends State<EventListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CareerPlannerTheme.neutralBackground,
        appBar: AppBar(
          title: Text('Sự Kiện'),
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: this.widget.articlesListRef.onValue,
            builder: (context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasData) {
                final data = EventData.fromSnapshot(snapshot.data.snapshot);
                if (data.events.length != null) {
                  return LiveList(
                    showItemInterval: Duration(milliseconds: 150),
                    showItemDuration: Duration(milliseconds: 200),
                    padding: EdgeInsets.only(left: 8, right: 8),
                    reAnimateOnVisibility: false,
                    scrollDirection: Axis.vertical,
                    itemCount: data.events.length,
                    itemBuilder: animationItemBuilder(
                      (index) {
                        final _event = data.events[index];
                        return EventCard(
                            event: _event, size: MediaQuery.of(context).size);
                      },
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  );
                } else {
                  return Container();
                }
              } else {
                return Container(child: LoadingWidget());
              }
            }));
  }

  Widget Function(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) animationItemBuilder(
    Widget Function(int index) child, {
    EdgeInsets padding = EdgeInsets.zero,
  }) =>
      (
        BuildContext context,
        int index,
        Animation<double> animation,
      ) =>
          FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),
              child: Padding(
                padding: padding,
                child: child(index),
              ),
            ),
          );
}
