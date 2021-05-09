class DenemeModel {
  String birthDay;
  String fullName;
  String mail;

  DenemeModel({this.birthDay, this.fullName, this.mail});

  DenemeModel.fromJson(Map<String, dynamic> json) {
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
}
