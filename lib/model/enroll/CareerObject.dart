// To parse this JSON data, do
//
//     final careerObject = careerObjectFromJson(jsonString);

// SAMPLE JSON
// {
// "id": 1,
// "career_name": "Tài Chính - Ngân Hàng",
// "image_path": "https://source.unsplash.com/800x600/?financial",
// "description": "sdfsjdflsf",
// "career_code": "BNAK_01"
// }

import 'dart:convert';

CareerObject careerObjectFromJson(String str) =>
    CareerObject.fromJson(json.decode(str));

String careerObjectToJson(CareerObject data) => json.encode(data.toJson());

class CareerObject {
  CareerObject({
    this.id,
    this.careerName,
    this.imagePath,
    this.description,
    this.careerCode,
  });

  int id;
  String careerName;
  String imagePath;
  String description;
  String careerCode;

  factory CareerObject.fromJson(Map<String, dynamic> json) => CareerObject(
        id: json["id"] == null ? null : json["id"],
        careerName: json["career_name"] == null ? null : json["career_name"],
        imagePath: json["image_path"] == null ? null : json["image_path"],
        description: json["description"] == null ? null : json["description"],
        careerCode: json["career_code"] == null ? null : json["career_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "career_name": careerName == null ? null : careerName,
        "image_path": imagePath == null ? null : imagePath,
        "description": description == null ? null : description,
        "career_code": careerCode == null ? null : careerCode,
      };
}
