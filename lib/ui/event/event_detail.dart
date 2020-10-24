import 'package:careerplanner/model/event/event_object.dart';
import 'package:careerplanner/ui/event/event_detail/event_detail_card_info.dart';
import 'package:careerplanner/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'event_detail/register_event_button.dart';

class EventDetail extends StatefulWidget {
  EventDetail({Key key, this.event}) : super(key: key);
  final EventObject event;
  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CareerPlannerTheme.neutralBackground,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    this.widget.event.eventName,
                    style: GoogleFonts.robotoSlabTextTheme()
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  this.widget.event.description,
                  style: GoogleFonts.robotoSlabTextTheme()
                      .caption
                      .copyWith(fontSize: 16),
                ),
                SizedBox(height: 16),
                EventDetailCardInfo(size: size, event: this.widget.event),
                RegisterEventButton(event: this.widget.event)
              ],
            ),
          )
        ]));
  }
}
