// To parse this JSON data, do
//
//     final questionObject = questionObjectFromJson(jsonString);

import 'dart:convert';

class QuestionObject {
  QuestionObject({
    this.id,
    this.question,
    this.group,
  });

  int id;
  String question;
  String group;

  factory QuestionObject.fromRawJson(String str) =>
      QuestionObject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionObject.fromJson(Map<String, dynamic> json) => QuestionObject(
        id: json["id"] == null ? null : json["id"],
        question: json["question"] == null ? null : json["question"],
        group: json["group"] == null ? null : json["group"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "question": question == null ? null : question,
        "group": group == null ? null : group,
      };
}
