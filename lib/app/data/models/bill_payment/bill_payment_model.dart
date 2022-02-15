import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';

class BillPaymentValidateModel {
  String? code;
  bool? isDigitable;

  BillPaymentValidateModel({this.code});

  BillPaymentValidateModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['isDigitable'] = this.isDigitable;
    return data;
  }
}

class BillPaymentConfirmModel {
  String? id;
  double? amount;
  String? password64;

  BillPaymentConfirmModel({this.id, this.amount});

  BillPaymentConfirmModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    password64 = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = SecurityUtils.encodeTo64(this.id ?? "");
    data['amount'] = SecurityUtils.encodeTo64(this.amount?.toString() ?? "");
    data['password'] = SecurityUtils.encodeTo64(this.password64 ?? "");
    return data;
  }
}

class BillPaymentValidateResponseModel {
  BillRecipient? recipient;
  String? id;
  String? dueDate;
  String? settleDate;
  bool? nextSettle;
  double? originalAmount;
  double? amount;
  String? amountFormatted;
  String? digitable;
  bool? allowEditAmount;
  BusinessHourPayment? businessHour;
  DiscountPayment? discountPayment;

  BillPaymentValidateResponseModel(
      {this.recipient,
      this.id,
      this.dueDate,
      this.settleDate,
      this.nextSettle,
      this.originalAmount,
      this.amount,
      this.amountFormatted,
      this.digitable,
      this.allowEditAmount});

  BillPaymentValidateResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dueDate = json['limitDate'];
    settleDate = json['confirmDate'];
    nextSettle = json['nextSettle'];
    originalAmount = json['originalAmount'];
    amount = json['amount'] ?? 0.0;
    amountFormatted = json['amountFormatted'];
    digitable = json['digitable'];
    allowEditAmount = json['allowEditAmount'];
    recipient = json['recipient'] != null
        ? BillRecipient.fromJson(json['recipient'])
        : null;
    businessHour = json['businessHours'] != null
        ? BusinessHourPayment.fromJson(json['businessHours'])
        : null;
    discountPayment = json['charges'] != null
        ? DiscountPayment.fromJson(json['charges'])
        : null;
  }
}

class BusinessHourPayment {
  String? start;
  String? end;

  BusinessHourPayment.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }
}

class DiscountPayment {
  double? discountAmount;

  DiscountPayment.fromJson(Map<String, dynamic> json) {
    discountAmount = json['discountAmount'];
  }
}

class BillPaymentConfirmResponseModel {
  BillRecipient? recipient;
  String? id;
  String? dueDate;
  String? settleDate;
  bool? nextSettle;
  double? originalAmount;
  double? amount;
  String? amountFormatted;
  String? digitable;
  BankAccount? customerAccount;
  String? authenticationCode;
  String? name;
  String? nick;

  BillPaymentConfirmResponseModel(
      {this.recipient,
      this.id,
      this.dueDate,
      this.settleDate,
      this.nextSettle,
      this.originalAmount,
      this.amount,
      this.amountFormatted,
      this.digitable,
      this.customerAccount,
      this.authenticationCode,
      this.name,
      this.nick});

  BillPaymentConfirmResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dueDate = json['dueDate'];
    settleDate = json['settleDate'];
    nextSettle = json['nextSettle'];
    originalAmount = json['originalAmount'];
    amount = json['amount'];
    amountFormatted = json['amountFormatted'];
    digitable = json['digitable'];
    recipient = json['recipient'] != null
        ? BillRecipient.fromJson(json['recipient'])
        : null;
    customerAccount = BankAccount.fromJson(json['customerAccount']);
    authenticationCode = json['authenticationCode'];
    name = json['customerName'];
    nick = json['customerNick'];
  }
}

class BillRecipient {
  String? name;
  String? documentNumber;

  BillRecipient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    documentNumber = json['documentNumber'];
  }
}
