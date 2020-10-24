// Sample JSON
// {
// "id": 1,
// "title": "sdfsdfsf",
// "link": "sdfsdfsdf",
// "image_path": "sdfsfds",
// "career_group": "social"
// }

// To parse this JSON data, do
//
//     final articleObject = articleObjectFromJson(jsonString);

import 'dart:convert';

class ArticleObject {
  ArticleObject({
    this.id,
    this.title,
    this.link,
    this.imagePath,
    this.careerGroup,
  });

  int id;
  String title;
  String link;
  String imagePath;
  String careerGroup;

  factory ArticleObject.fromRawJson(String str) =>
      ArticleObject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleObject.fromJson(Map<String, dynamic> json) => ArticleObject(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        link: json["link"] == null ? null : json["link"],
        imagePath: json["image_path"] == null ? null : json["image_path"],
        careerGroup: json["career_group"] == null ? null : json["career_group"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "link": link == null ? null : link,
        "image_path": imagePath == null ? null : imagePath,
        "career_group": careerGroup == null ? null : careerGroup,
      };
}
