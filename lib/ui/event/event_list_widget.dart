import 'package:flutter/material.dart';

class EventListWidget extends StatefulWidget {
  EventListWidget({Key key}) : super(key: key);

  @override
  _EventListWidgetState createState() => _EventListWidgetState();
}

class _EventListWidgetState extends State<EventListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: []),
    );
  }
}
