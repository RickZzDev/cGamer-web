import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/utils/utils_export.dart';

class SendExternTransferModel {
  String? password;
  String? identifier;
  String? name;
  String? amount;
  String? description;

  CustomerAccount? customerAccount = CustomerAccount();

  SendExternTransferModel({
    this.password,
    this.identifier,
    this.name,
    this.amount,
    this.description,
  });

  dynamic fromTedInfoModelToJson(TedInfoModel? tedInfoModel) {
    this.name = SecurityUtils.encodeTo64(tedInfoModel?.fullName ?? "");
    this.amount = SecurityUtils.encodeTo64(tedInfoModel?.ammount ?? "");
    this.password = SecurityUtils.encodeTo64(tedInfoModel?.password64 ?? "");
    this.identifier = tedInfoModel?.cnpj != null
        ? SecurityUtils.encodeTo64(tedInfoModel?.cnpj ?? "")
        : SecurityUtils.encodeTo64(tedInfoModel?.cpf ?? "");
    this.description =
        SecurityUtils.encodeTo64(tedInfoModel?.description ?? "");

    this.customerAccount?.account =
        SecurityUtils.encodeTo64(tedInfoModel?.accountNumber ?? "");

    this.customerAccount?.accountType =
        tedInfoModel?.accounType == "Conta Corrente"
            ? SecurityUtils.encodeTo64("CHECKING")
            : tedInfoModel?.accounType == "Conta Poupança"
                ? SecurityUtils.encodeTo64("SAVINGS")
                : SecurityUtils.encodeTo64(tedInfoModel?.accounType ?? "");

    this.customerAccount?.bankNumber =
        SecurityUtils.encodeTo64(tedInfoModel?.bankCode ?? "");

    this.customerAccount?.agency =
        SecurityUtils.encodeTo64(tedInfoModel?.agency ?? "");
    return toJson();
  }

  SendExternTransferModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    identifier = json['identifier'];
    name = json['name'];
    amount = json['amount'];
    description = json['description'];
    customerAccount = json['customerAccount'] != null
        ? new CustomerAccount.fromJson(json['customerAccount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['identifier'] = this.identifier;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['description'] = this.description;
    if (this.customerAccount != null) {
      data['customerAccount'] = this.customerAccount?.toJson();
    }
    return data;
  }
}

class CustomerAccount {
  String? bankNumber;
  String? agency;
  String? account;
  String? accountType;

  CustomerAccount(
      {this.bankNumber, this.agency, this.account, this.accountType});

  CustomerAccount.fromJson(Map<String, dynamic> json) {
    bankNumber = json['bankNumber'];
    agency = json['agency'];
    account = json['account'];
    accountType = json['accountType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankNumber'] = this.bankNumber;
    data['agency'] = this.agency;
    data['account'] = this.account;
    data['accountType'] = this.accountType;
    return data;
  }
}
