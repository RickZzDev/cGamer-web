import 'package:cGamer/app/data/data_exports.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';

class SaveExternContactModel {
  String? identifier;
  String? name;
  CustomerAccount? customerAccount = CustomerAccount();

  SaveExternContactModel({this.identifier, this.name});

  SaveExternContactModel.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    name = json['name'];
    customerAccount = json['customerAccount'] != null
        ? new CustomerAccount.fromJson(json['customerAccount'])
        : null;
  }

  dynamic fromTedInfoModel(TedInfoModel? _infoModel) {
    identifier = _infoModel?.cpf != null ? _infoModel?.cpf : _infoModel?.cnpj;
    name = _infoModel?.fullName;
    customerAccount?.account = _infoModel?.accountNumber;
    customerAccount?.accountType = _infoModel?.accounType;
    customerAccount?.bank = _infoModel?.bank;
    customerAccount?.bankNumber = _infoModel?.bankCode;
    customerAccount?.agency = _infoModel?.agency;

    return toJson();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = SecurityUtils.encodeTo64(this.identifier ?? "");
    data['name'] = this.name;
    if (this.customerAccount != null) {
      data['customerAccount'] = this.customerAccount?.toJson();
    }
    return data;
  }
}

class CustomerAccount {
  String? bankNumber;
  String? account;
  String? accountType;
  String? bank;
  String? agency;

  CustomerAccount({this.bankNumber, this.account, this.accountType, this.bank});

  CustomerAccount.fromJson(Map<String, dynamic> json) {
    bankNumber = json['bankCode'];
    account = json['account'];
    accountType = json['accountType'];
    bank = json['bank'];
    agency = json['agency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankCode'] = int.parse(bankNumber ?? "0");
    // data['bankNumber'] = int.parse(this.bankNumber);
    data['account'] = this.account;
    data['accountType'] = this.accountType;
    data['bank'] = this.bank;
    data['agency'] = this.agency;
    return data;
  }
}
