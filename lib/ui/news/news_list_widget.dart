import 'package:auto_animated/auto_animated.dart';
import 'package:careerplanner/model/news/article_data.dart';
import 'package:careerplanner/ui/news/news_card.dart';
import 'package:careerplanner/ui/shared/loading_widget.dart';
import 'package:careerplanner/util/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NewsListWidget extends StatefulWidget {
  NewsListWidget({Key key}) : super(key: key);
  final DatabaseReference articlesListRef =
      constants.database.reference().child('news');
  @override
  _NewsListWidgetState createState() => _NewsListWidgetState();
}

class _NewsListWidgetState extends State<NewsListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tin Tức'),
        elevation: 0,
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
        child: StreamBuilder(
            stream: this.widget.articlesListRef.onValue,
            builder: (context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasData) {
                final data = NewsData.fromSnapshot(snapshot.data.snapshot);
                if (data.articles.length != null) {
                  return LiveList(
                    showItemInterval: Duration(milliseconds: 150),
                    showItemDuration: Duration(milliseconds: 200),
                    padding: EdgeInsets.only(left: 8, right: 8),
                    reAnimateOnVisibility: false,
                    scrollDirection: Axis.vertical,
                    itemCount: data.articles.length,
                    itemBuilder: animationItemBuilder(
                      (index) {
                        final _article = data.articles[index];
                        return NewsCard(article: _article);
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
            }),
      ),
    );
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
  @override
  void dispose() {
    super.dispose();
  }
}
