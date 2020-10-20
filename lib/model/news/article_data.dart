import 'package:careerplanner/model/news/article_object.dart';
import 'package:firebase_database/firebase_database.dart';

class NewsData {
  List<ArticleObject> articles;

  NewsData({this.articles});

  factory NewsData.fromSnapshot(DataSnapshot snapshot) {
    List<ArticleObject> articlesList = [];
    articlesList.clear();
    List<dynamic> values = snapshot.value;
    values.forEach((element) {
      if (element != null) {
        articlesList
            .add(ArticleObject.fromJson(Map<String, dynamic>.from(element)));
      }
    });
    return NewsData(articles: articlesList);
  }
}
