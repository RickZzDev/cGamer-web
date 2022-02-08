class ChangePasswordModel {
  String? password;
  String? newPassword;

  ChangePasswordModel({this.password, this.newPassword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['newPassword'] = this.newPassword;
    return data;
  }
}
