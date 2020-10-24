// Sample JSON
// {
// {
// "id": 1,
// "event_name": "sdfsdfsf",
// "image_path": "agfdgdfg",
// "event_by": "sdfsdf",
// "location": "sdfsfd",
// "description": "sdfsdf",
// "start": "24/10/2020 14:30:00",
// "end": "24/10/2020 16:30:00"
// }

// To parse this JSON data, do
//
//     final eventObject = eventObjectFromJson(jsonString);

import 'dart:convert';

class EventObject {
  EventObject({
    this.id,
    this.eventName,
    this.imagePath,
    this.eventBy,
    this.location,
    this.description,
    this.start,
    this.end,
    this.careerGroup,
  });

  int id;
  String eventName;
  String imagePath;
  String eventBy;
  String location;
  String description;
  String start;
  String end;
  String careerGroup;

  factory EventObject.fromRawJson(String str) =>
      EventObject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EventObject.fromJson(Map<String, dynamic> json) => EventObject(
        id: json["id"] == null ? null : json["id"],
        eventName: json["event_name"] == null ? null : json["event_name"],
        imagePath: json["image_path"] == null ? null : json["image_path"],
        eventBy: json["event_by"] == null ? null : json["event_by"],
        location: json["location"] == null ? null : json["location"],
        description: json["description"] == null ? null : json["description"],
        start: json["start"] == null ? null : json["start"],
        end: json["end"] == null ? null : json["end"],
        careerGroup: json["career_group"] == null ? null : json["career_group"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "event_name": eventName == null ? null : eventName,
        "image_path": imagePath == null ? null : imagePath,
        "event_by": eventBy == null ? null : eventBy,
        "location": location == null ? null : location,
        "description": description == null ? null : description,
        "start": start == null ? null : start,
        "end": end == null ? null : end,
        "career_group": careerGroup == null ? null : careerGroup,
      };
}
