class Account {
  String uid;
  String name;
  String phone;
  String school;
  String email;
  int age;
  String accountType;

  Account(
      {this.uid,
      this.name,
      this.phone,
      this.school,
      this.email,
      this.age,
      this.accountType});

  Account.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    phone = json['phone'];
    school = json['school'];
    email = json['email'];
    age = json['age'];
    accountType = json['account_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['school'] = this.school;
    data['email'] = this.email;
    data['age'] = this.age;
    data['account_type'] = this.accountType;
    return data;
  }
}
