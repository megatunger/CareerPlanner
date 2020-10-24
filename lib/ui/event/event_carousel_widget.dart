import 'package:careerplanner/model/event/event_data.dart';
import 'package:careerplanner/ui/event/event_card.dart';
import 'package:careerplanner/ui/shared/empty_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EventCarouselWidget extends StatefulWidget {
  EventCarouselWidget({Key key, this.stream, this.screenSize})
      : super(key: key);
  Stream<Event> stream;
  Size screenSize;
  @override
  _EventCarouselWidgetState createState() => _EventCarouselWidgetState();
}

class _EventCarouselWidgetState extends State<EventCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: this.widget.stream,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            final data = EventData.fromSnapshot(snapshot.data.snapshot).events;
            if (data.length == 0) {
              return EmptyState();
            }
            return CarouselSlider(
              options: CarouselOptions(
                height: this.widget.screenSize.height * 0.3,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: data.map((event) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: this.widget.screenSize.width,
                        margin: EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: EventCard(
                            event: event, size: this.widget.screenSize));
                  },
                );
              }).toList(),
            );
          } else {
            return LinearProgressIndicator();
          }
        });
  }
}
