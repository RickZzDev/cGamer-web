import 'package:cGamer/app/data/data_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TedInfoModel {
  TedInfoModel(
      {this.method,
      this.cpf,
      this.fullName,
      this.bank,
      this.accountNumber,
      this.transferDate});

  String? ammountWithTax;
  String? ammount;
  String? fullName;
  String? bank;
  String? userName;
  String? agency;
  String? accountNumber;
  String? accounType;
  String? method;
  String? transferDate;
  String? transferTax;
  String? cpf;
  String? cnpj;
  String? password64;
  String? bankCode;
  String? description;

  TedInfoModel.fromInternalUserJson(
      {required Map<String, dynamic> json,
      String? ammountValue,
      String? userNameValue,
      String? ammountWithTaxValue,
      String? taxValue,
      String? cpfValue}) {
    this.userName = userNameValue;
    this.ammountWithTax = ammountWithTaxValue;
    this.ammount = ammountValue;
    this.transferTax = taxValue;
    this.bank = "Acesso Soluções de Pagamentos S.A.";
    this.method = "Transferência entre contas Gamers";
    this.transferDate = DateFormat('dd/MM/yyyy').format(
      DateTime.now(),
    );
    this.cpf = cpfValue != null ? cpfValue : json['customer']['customerCpf'];
    this.fullName = json['customer']['customerName'];
    // userName = userName != null ? userName : fullName;
  }

  TedInfoModel fromExternContact(
      {required dynamic user,
      required String ammount,
      required String ammountWithTax,
      required String tax,
      int? index}) {
    TedInfoModel _infoModel = TedInfoModel();
    if (user is LastContacts) {
      _infoModel.fullName = user.name;
      _infoModel.agency = user.customerAccount?.agency;
      _infoModel.bank = user.customerAccount?.bank;
      _infoModel.accountNumber = user.customerAccount?.account;
      _infoModel.accounType = user.customerAccount?.accountType;
      _infoModel.ammount = ammount;
      _infoModel.ammountWithTax = ammountWithTax;
      _infoModel.bankCode = user.customerAccount?.bankCode.toString();
      _infoModel.cpf = user.identifier;
      _infoModel.method = "TED";
      _infoModel.transferTax = tax;
      _infoModel.transferDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

      return _infoModel;
    } else {
      _infoModel.fullName = user.name;
      _infoModel.agency = user.accounts[index]['agency'];
      _infoModel.bank = user.accounts[index]["bank"];
      _infoModel.accountNumber = user.accounts[index]["account"];
      _infoModel.accounType = user.accounts[index]["accountType"];
      _infoModel.ammount = ammount;
      _infoModel.ammountWithTax = ammountWithTax;
      _infoModel.bankCode = user.accounts[index]["bankCode"].toString();
      _infoModel.cpf = user.identifier;
      _infoModel.method = "TED";
      _infoModel.transferTax = tax;
      _infoModel.transferDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

      return _infoModel;
    }
  }
}
