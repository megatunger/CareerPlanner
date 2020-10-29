// SAMPLE JSON
// {
// "uid": "sdfsdfsfs",
// "account_type": "student",
// "name": "Hoang",
// "age": "21",
// "email": "megatunger@gmail.com",
// "phone": "0967134899",
// "school": "werwrew",
// "gender": "Nu",
// "ref_user": "sdfsfsf",
// "wallet_balance": 120,
// "timestamp": 1603720137987
// }

// To parse this JSON data, do
//
//     final accountObject = accountObjectFromJson(jsonString);

import 'dart:convert';

class AccountObject {
  AccountObject({
    this.uid,
    this.accountType,
    this.name,
    this.age,
    this.email,
    this.phone,
    this.school,
    this.gender,
    this.refUser,
    this.walletBalance,
    this.timestamp,
  });

  String uid;
  String accountType;
  String name;
  String age;
  String email;
  String phone;
  String school;
  String gender;
  String refUser;
  int walletBalance;
  int timestamp;

  factory AccountObject.fromRawJson(String str) =>
      AccountObject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountObject.fromJson(Map<String, dynamic> json) => AccountObject(
        uid: json["uid"] == null ? null : json["uid"],
        accountType: json["account_type"] == null ? null : json["account_type"],
        name: json["name"] == null ? null : json["name"],
        age: json["age"] == null ? null : json["age"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        school: json["school"] == null ? null : json["school"],
        gender: json["gender"] == null ? null : json["gender"],
        refUser: json["ref_user"] == null ? null : json["ref_user"],
        walletBalance:
            json["wallet_balance"] == null ? null : json["wallet_balance"],
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "account_type": accountType == null ? null : accountType,
        "name": name == null ? null : name,
        "age": age == null ? null : age,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "school": school == null ? null : school,
        "gender": gender == null ? null : gender,
        "ref_user": refUser == null ? null : refUser,
        "wallet_balance": walletBalance == null ? null : walletBalance,
        "timestamp": timestamp == null ? null : timestamp,
      };
}
