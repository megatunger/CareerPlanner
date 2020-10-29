// Sample JSON
// {
// "id": 1,
// "group_code": "sdff",
// "group_title": "sjdfsldf",
// "group_description": "sdjfsdf",
// "image": "sdjfsdfjo"
// }
// To parse this JSON data, do
//
//     final careerGroupObject = careerGroupObjectFromJson(jsonString);

import 'dart:convert';

class CareerGroupObject {
  CareerGroupObject({
    this.id,
    this.groupCode,
    this.groupTitle,
    this.groupDescription,
    this.image,
  });

  int id;
  String groupCode;
  String groupTitle;
  String groupDescription;
  String image;

  factory CareerGroupObject.fromRawJson(String str) =>
      CareerGroupObject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CareerGroupObject.fromJson(Map<String, dynamic> json) =>
      CareerGroupObject(
        id: json["id"] == null ? null : json["id"],
        groupCode: json["group_code"] == null ? null : json["group_code"],
        groupTitle: json["group_title"] == null ? null : json["group_title"],
        groupDescription: json["group_description"] == null
            ? null
            : json["group_description"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "group_code": groupCode == null ? null : groupCode,
        "group_title": groupTitle == null ? null : groupTitle,
        "group_description": groupDescription == null ? null : groupDescription,
        "image": image == null ? null : image,
      };
}
