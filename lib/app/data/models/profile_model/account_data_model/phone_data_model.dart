class PhoneAccount {
  String? phone;
  PhoneAccount({this.phone});

  PhoneAccount.fromJson(Map<String, dynamic> json) {
    phone = json['customerPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerPhone'] = this.phone;
    return data;
  }
}
