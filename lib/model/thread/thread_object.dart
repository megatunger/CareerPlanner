// SAMPLE JSON
// {
// "timestamp": 1111223123,
// "id": "sdfsf",
// "title": "dfsdfsf",
// "description": "sfsdf",
// "uid": "fshdjfksh",
// "images_object": [{"id": "sdfsf", "path": "sdfs"}],
// "comment_object": [
// {"id": "dfsdfs", "uid": "12312425", "body": "sdfsf", "timestamp": 12312312, "images_object": [{"id": "sdfsf", "path": "sdfs"}]},
// {"id": "dfsdfs", "uid": "12312425", "body": "sdfsf", "timestamp": 12312312, "images_object": [{"id": "sdfsf", "path": "sdfs"}]}
// ]
// }

// To parse this JSON data, do
//
//     final threadObject = threadObjectFromJson(jsonString);

import 'dart:convert';

class ThreadObject {
  ThreadObject({
    this.timestamp,
    this.id,
    this.title,
    this.description,
    this.uid,
    this.imagesObject,
    this.commentObject,
  });

  int timestamp;
  String id;
  String title;
  String description;
  String uid;
  List<ImagesObject> imagesObject;
  List<CommentObject> commentObject;

  factory ThreadObject.fromRawJson(String str) =>
      ThreadObject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ThreadObject.fromJson(Map<String, dynamic> json) => ThreadObject(
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        uid: json["uid"] == null ? null : json["uid"],
        imagesObject: json["images_object"] == null
            ? null
            : List<ImagesObject>.from(
                json["images_object"].map((x) => ImagesObject.fromJson(x))),
        commentObject: json["comment_object"] == null
            ? null
            : List<CommentObject>.from(
                json["comment_object"].map((x) => CommentObject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp == null ? null : timestamp,
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "uid": uid == null ? null : uid,
        "images_object": imagesObject == null
            ? null
            : List<dynamic>.from(imagesObject.map((x) => x.toJson())),
        "comment_object": commentObject == null
            ? null
            : List<dynamic>.from(commentObject.map((x) => x.toJson())),
      };
}

class CommentObject {
  CommentObject({
    this.id,
    this.uid,
    this.body,
    this.timestamp,
    this.imagesObject,
  });

  String id;
  String uid;
  String body;
  int timestamp;
  List<ImagesObject> imagesObject;

  factory CommentObject.fromRawJson(String str) =>
      CommentObject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentObject.fromJson(Map<String, dynamic> json) => CommentObject(
        id: json["id"] == null ? null : json["id"],
        uid: json["uid"] == null ? null : json["uid"],
        body: json["body"] == null ? null : json["body"],
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
        imagesObject: json["images_object"] == null
            ? null
            : List<ImagesObject>.from(
                json["images_object"].map((x) => ImagesObject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uid": uid == null ? null : uid,
        "body": body == null ? null : body,
        "timestamp": timestamp == null ? null : timestamp,
        "images_object": imagesObject == null
            ? null
            : List<dynamic>.from(imagesObject.map((x) => x.toJson())),
      };
}

class ImagesObject {
  ImagesObject({
    this.id,
    this.path,
  });

  String id;
  String path;

  factory ImagesObject.fromRawJson(String str) =>
      ImagesObject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImagesObject.fromJson(Map<String, dynamic> json) => ImagesObject(
        id: json["id"] == null ? null : json["id"],
        path: json["path"] == null ? null : json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "path": path == null ? null : path,
      };
}
