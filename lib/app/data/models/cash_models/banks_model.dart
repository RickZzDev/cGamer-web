class BanksModel {
  List<Banks>? banks;

  BanksModel({this.banks});

  BanksModel.fromJson(Map<String, dynamic> json) {
    if (json['banks'] != null) {
      banks = <Banks>[];
      json['banks'].forEach((v) {
        banks?.add(new Banks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banks != null) {
      data['banks'] = this.banks?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banks {
  String? bankCode;
  String? name;

  Banks({this.bankCode, this.name});

  Banks.fromJson(Map<String, dynamic> json) {
    bankCode = json['bankCode'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankCode'] = this.bankCode;
    data['name'] = this.name;
    return data;
  }
}
