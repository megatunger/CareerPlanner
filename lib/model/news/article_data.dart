import 'package:careerplanner/model/news/article_object.dart';
import 'package:firebase_database/firebase_database.dart';

class NewsData {
  List<ArticleObject> articles;

  NewsData({this.articles});

  factory NewsData.fromSnapshot(DataSnapshot snapshot) {
    List<ArticleObject> articlesList = [];
    articlesList.clear();
    if (snapshot.value != null) {
      if (snapshot.value.runtimeType.toString() ==
          "_InternalLinkedHashMap<dynamic, dynamic>") {
        Map<String, dynamic>.from(snapshot.value).forEach((key, value) {
          articlesList
              .add(ArticleObject.fromJson(Map<String, dynamic>.from(value)));
        });
      } else {
        List<dynamic> values = snapshot.value;
        values.forEach((element) {
          if (element != null) {
            articlesList.add(
                ArticleObject.fromJson(Map<String, dynamic>.from(element)));
          }
        });
      }
    }
    return NewsData(articles: articlesList);
  }
}
