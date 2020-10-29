// SAMPLE JSON

// {
// "uid": "sdfsfsdf",
// "mentor_name": "sdfsfs",
// "mentor_description": "sdfsfsf",
// "mentor_image": "sdfsfsdfs",
// "mentor_school": "sfsdfs",
// "verify": "verified"
// }

// To parse this JSON data, do
//
//     final mentorObject = mentorObjectFromJson(jsonString);

import 'dart:convert';

class MentorObject {
  MentorObject({
    this.uid,
    this.mentorName,
    this.mentorDescription,
    this.mentorImage,
    this.mentorSchool,
    this.verify,
  });

  String uid;
  String mentorName;
  String mentorDescription;
  String mentorImage;
  String mentorSchool;
  String verify;

  factory MentorObject.fromRawJson(String str) =>
      MentorObject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MentorObject.fromJson(Map<String, dynamic> json) => MentorObject(
        uid: json["uid"] == null ? null : json["uid"],
        mentorName: json["mentor_name"] == null ? null : json["mentor_name"],
        mentorDescription: json["mentor_description"] == null
            ? null
            : json["mentor_description"],
        mentorImage: json["mentor_image"] == null ? null : json["mentor_image"],
        mentorSchool:
            json["mentor_school"] == null ? null : json["mentor_school"],
        verify: json["verify"] == null ? null : json["verify"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "mentor_name": mentorName == null ? null : mentorName,
        "mentor_description":
            mentorDescription == null ? null : mentorDescription,
        "mentor_image": mentorImage == null ? null : mentorImage,
        "mentor_school": mentorSchool == null ? null : mentorSchool,
        "verify": verify == null ? null : verify,
      };
}
