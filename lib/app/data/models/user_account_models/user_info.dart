class UserRegisterModel {
  String? name;
  String? cpf;
  String? nick;
  String? birth;
  String? email;
  String? password;
  String? indicationCode;
  String? username;
  String? motherName;

  UserRegisterModel(
      {id,
      this.name,
      this.nick,
      this.email,
      this.birth,
      this.cpf,
      this.password,
      this.indicationCode,
      this.username,
      this.motherName});

  // UserRegisterModel.fromJson(Map<String, dynamic> json) {
  //   this.id = json['id'];
  //   this.name = json['name'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cpf'] = this.cpf;
    data['nick'] = this.nick;
    data['birth'] = this.birth;
    data['email'] = this.email;
    data['password'] = this.password;
    data['invitedFrom'] = this.indicationCode;
    data['username'] = this.username;
    data['motherName'] = this.motherName;

    return data;
  }
}
