import 'package:cGamer/app/utils/generic_utils/security_utils.dart';

class VirtualCardRequestModel {
  String? name;
  String? alias;
  String? password;
  String? accountPassword;

  VirtualCardRequestModel(
      {this.name, this.alias, this.accountPassword, this.password});

  // UserRegisterModel.fromJson(Map<String, dynamic> json) {
  //   this.id = json['id'];
  //   this.name = json['name'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardName'] = this.name;
    data['alias'] = this.alias;
    data['password'] = SecurityUtils.encodeTo64(this.password ?? "");
    data['customerPassword'] =
        SecurityUtils.encodeTo64(this.accountPassword ?? "");
    return data;
  }
}

class VirtualCardModel {
  String? cardLastFourDigits;
  String? cardName;
  String? cardAlias;
  String? cardType;
  String? cardStatus;

  VirtualCardModel(
      {this.cardLastFourDigits,
      this.cardName,
      this.cardAlias,
      this.cardType,
      this.cardStatus});

  VirtualCardModel.fromJson(Map<String, dynamic> json) {
    this.cardLastFourDigits = json['cardLastFourDigits'];
    this.cardName = json['cardName'];
    this.cardAlias = json['cardAlias'];
    this.cardType = json['cardType'];
    this.cardStatus = json['cardStatus'];
  }
}

class PCIVirtualCardModel {
  String? cardNumber;
  String? cardCvv;
  String? cardExpirationDate;

  PCIVirtualCardModel({this.cardNumber, this.cardCvv, this.cardExpirationDate});

  PCIVirtualCardModel.fromJson(Map<String, dynamic> json) {
    this.cardNumber = json['cardNumber'];
    this.cardCvv = json['cardCvv'];
    this.cardExpirationDate = json['cardExpirationDate'];
  }
}

class VirtualCardPasswordsRequestModel {
  String? password;
  String? accountPassword;

  VirtualCardPasswordsRequestModel({this.accountPassword, this.password});

  // UserRegisterModel.fromJson(Map<String, dynamic> json) {
  //   this.id = json['id'];
  //   this.name = json['name'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = SecurityUtils.encodeTo64(this.password ?? "");
    data['customerPassword'] =
        SecurityUtils.encodeTo64(this.accountPassword ?? "");
    return data;
  }
}
