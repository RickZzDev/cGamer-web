class AuthModel {
  String? token;

  AuthModel({this.token});

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

class AuthRequestModel {
  String? cpf;
  String? password;

  AuthRequestModel({this.cpf, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpf'] = this.cpf;
    data['password'] = this.password;
    return data;
  }
}
