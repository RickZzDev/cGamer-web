class TicketListModel {
  List<Bankslips>? bankslips;

  TicketListModel({this.bankslips});

  TicketListModel.fromJson(Map<String, dynamic> json) {
    if (json['bankslips'] != null) {
      bankslips = <Bankslips>[];
      json['bankslips'].forEach((v) {
        bankslips?.add(new Bankslips.fromJson(v));
      });
    }
  }
}

class Bankslips {
  dynamic? amount;
  String? status;
  String? barCode;
  String? dueDate;
  String? paidOutDate;
  String? authenticationCode;
  PaymentBankslip? payment;

  Bankslips(
      {this.amount,
      this.status,
      this.barCode,
      this.dueDate,
      this.paidOutDate,
      this.authenticationCode,
      this.payment});

  Bankslips.fromJson(Map<String, dynamic> json) {
    amount = json['amount']['value'];
    status = json['status'];
    barCode = json['digitable'];
    dueDate = json['limitDate'];
    if (json['payment'] != null) {
      payment = PaymentBankslip.fromJson(json['payment']);
    }

    authenticationCode = json['authenticationCode'];
  }
}

class PaymentBankslip {
  String? id;
  String? paidOutDate;

  PaymentBankslip({this.id, this.paidOutDate});
  PaymentBankslip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paidOutDate = json['paymentDate'];
  }
}
