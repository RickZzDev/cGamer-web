import 'dart:convert';

import 'package:cGamer/app/data/models/models_export.dart';

class TransferResponseModel {
  FromCustomer? fromCustomer;
  ToCustomer? toCustomer;
  String? authenticationCode;

  TransferResponseModel(
      {this.fromCustomer, this.toCustomer, this.authenticationCode});

  TransferResponseModel.fromJson(Map<String, dynamic> json) {
    fromCustomer = json['fromCustomer'] != null
        ? new FromCustomer.fromJson(json['fromCustomer'])
        : null;
    toCustomer = json['toCustomer'] != null
        ? new ToCustomer.fromJson(json['toCustomer'])
        : null;
    authenticationCode = json['authenticationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fromCustomer != null) {
      data['fromCustomer'] = this.fromCustomer?.toJson();
    }
    if (this.toCustomer != null) {
      data['toCustomer'] = this.toCustomer?.toJson();
    }
    data['authenticationCode'] = this.authenticationCode;
    return data;
  }
}

class FromCustomer {
  String? customerName;
  String? customerNick;
  BankAccount? customerAccount;
  FromCustomer({this.customerName, this.customerNick, this.customerAccount});

  FromCustomer.fromJson(Map<String, dynamic> json) {
    customerName = utf8.decode(json['customerName'].toString().codeUnits);
    customerNick = json['customerNick'];
    customerAccount = json['customerAccount'] != null
        ? new BankAccount.fromJson(json['customerAccount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['customerNick'] = this.customerNick;
    if (this.customerAccount != null) {
      data['customerAccount'] = this.customerAccount?.toJson();
    }
    return data;
  }
}

class CustomerAccount {
  String? bank;
  int? bankNumber;
  String? agency;
  String? account;

  CustomerAccount({this.bank, this.bankNumber, this.agency, this.account});

  CustomerAccount.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    bankNumber = json['bankNumber'];
    agency = json['agency'];
    account = json['account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank'] = this.bank;
    data['bankNumber'] = this.bankNumber;
    data['agency'] = this.agency;
    data['account'] = this.account;
    return data;
  }
}

class ToCustomer {
  String? customerName;
  String? customerNick;
  String? costumerDocument;

  ToCustomer({this.customerName, this.customerNick, this.costumerDocument});

  ToCustomer.fromJson(Map<String, dynamic> json) {
    customerName = utf8.decode(json['customerName'].toString().codeUnits);
    customerNick = json['customerNick'] != null ? json['customerNick'] : null;
    costumerDocument = json['customerCpf'] != null
        ? json['customerCpf']
        : json['customerDocument'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['customerNick'] = this.customerNick;
    data['costumerDocument'] = this.costumerDocument;
    return data;
  }
}
