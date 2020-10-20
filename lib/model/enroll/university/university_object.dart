// SAMPLE JSON

// {
// "image_path": "https://sie.hust.edu.vn/wp-content/uploads/2017/06/179519368553224046057841704204869752823113n-1-600x384.jpg",
// "tuyen_sinh_link": "https://www.hust.edu.vn/thong-tin-tuyen-sinh",
// "id": 1,
// "nganh_dao_tao_link": "https://www.hust.edu.vn/nganh-tuyen-sinh",
// "university_name": "Đại học Bách Khoa Hà Nội",
// "gioi_thieu_link": "https://www.hust.edu.vn/gioi-thieu",
// "diem_nam_gan_day_link": "https://vtc.vn/diem-chuan-3-nam-gan-day-cua-dh-bach-khoa-ha-noi-ar566738.html",
// "lien_he_link": "https://www.hust.edu.vn/web/vi/lien-he",
// "career_group": "realistic"
// }

import 'dart:convert';

class UniversityObject {
  UniversityObject({
    this.imagePath,
    this.tuyenSinhLink,
    this.id,
    this.nganhDaoTaoLink,
    this.universityName,
    this.gioiThieuLink,
    this.diemNamGanDayLink,
    this.lienHeLink,
    this.careerGroup,
  });

  String imagePath;
  String tuyenSinhLink;
  int id;
  String nganhDaoTaoLink;
  String universityName;
  String gioiThieuLink;
  String diemNamGanDayLink;
  String lienHeLink;
  String careerGroup;

  factory UniversityObject.fromRawJson(String str) =>
      UniversityObject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UniversityObject.fromJson(Map<String, dynamic> json) =>
      UniversityObject(
        imagePath: json["image_path"] == null ? null : json["image_path"],
        tuyenSinhLink:
            json["tuyen_sinh_link"] == null ? null : json["tuyen_sinh_link"],
        id: json["id"] == null ? null : json["id"],
        nganhDaoTaoLink: json["nganh_dao_tao_link"] == null
            ? null
            : json["nganh_dao_tao_link"],
        universityName:
            json["university_name"] == null ? null : json["university_name"],
        gioiThieuLink:
            json["gioi_thieu_link"] == null ? null : json["gioi_thieu_link"],
        diemNamGanDayLink: json["diem_nam_gan_day_link"] == null
            ? null
            : json["diem_nam_gan_day_link"],
        lienHeLink: json["lien_he_link"] == null ? null : json["lien_he_link"],
        careerGroup: json["career_group"] == null ? null : json["career_group"],
      );

  Map<String, dynamic> toJson() => {
        "image_path": imagePath == null ? null : imagePath,
        "tuyen_sinh_link": tuyenSinhLink == null ? null : tuyenSinhLink,
        "id": id == null ? null : id,
        "nganh_dao_tao_link": nganhDaoTaoLink == null ? null : nganhDaoTaoLink,
        "university_name": universityName == null ? null : universityName,
        "gioi_thieu_link": gioiThieuLink == null ? null : gioiThieuLink,
        "diem_nam_gan_day_link":
            diemNamGanDayLink == null ? null : diemNamGanDayLink,
        "lien_he_link": lienHeLink == null ? null : lienHeLink,
        "career_group": careerGroup == null ? null : careerGroup,
      };
}
