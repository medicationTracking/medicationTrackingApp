class UserDataModel {
  String birthDay;
  String fullName;
  String mail;

  UserDataModel({this.birthDay, this.fullName, this.mail});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    birthDay = json['birthDay'];
    fullName = json['fullName'];
    mail = json['mail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthDay'] = this.birthDay;
    data['fullName'] = this.fullName;
    data['mail'] = this.mail;
    return data;
  }

  String toString() {
    return "birthday: $birthDay, fullname: $fullName, mail: $mail";
  }
}
