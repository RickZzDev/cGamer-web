class RetrivePasswordModel {
  String? code;
  String? newPassword;
  String? email;

  RetrivePasswordModel({id, this.email, this.code, this.newPassword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['code'] = this.code;
    data['newPassword'] = this.newPassword;
    return data;
  }
}
