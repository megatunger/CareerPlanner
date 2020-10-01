class CareerObject {
  int id;
  String careerName;
  String imagePath;

  CareerObject({this.id, this.careerName, this.imagePath});

  CareerObject.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    careerName = json['career_name'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['career_name'] = this.careerName;
    data['image_path'] = this.imagePath;
    return data;
  }
}
