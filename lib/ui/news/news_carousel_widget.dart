import 'package:careerplanner/model/news/article_data.dart';
import 'package:careerplanner/ui/news/news_card.dart';
import 'package:careerplanner/ui/shared/empty_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NewsCarouselWidget extends StatefulWidget {
  NewsCarouselWidget({Key key, this.stream, this.screenSize}) : super(key: key);
  Stream<Event> stream;
  Size screenSize;
  @override
  _NewsCarouselWidgetState createState() => _NewsCarouselWidgetState();
}

class _NewsCarouselWidgetState extends State<NewsCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: this.widget.stream,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            final data = NewsData.fromSnapshot(snapshot.data.snapshot)
                .articles;
            if (data.length == 0) {
              return EmptyState();
            }
            return CarouselSlider(
              options: CarouselOptions(
                height: this.widget.screenSize.height * 0.2,
                scrollDirection: Axis.vertical,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: NewsData.fromSnapshot(snapshot.data.snapshot)
                  .articles
                  .map((article) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: this.widget.screenSize.width,
                        margin: EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: NewsCard(article: article));
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
