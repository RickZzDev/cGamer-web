class PaymentGiftcardModel {
  String? id;
  String? status;
  String? pin;
  Transaction? transaction;
  String? authorization_code;

  PaymentGiftcardModel.fromJson(Map<String, dynamic> map) {
    if (map['transaction'] != null) {
      this.transaction = Transaction.fromJson(map['transaction']);
    } else {
      this.id = map['id'];
      this.pin = map['pin'];
      this.authorization_code = map['authorization_code'];
    }
  }
}

class Transaction {
  String? transactionId;
  String? key;
  String? url;

  Transaction.fromJson(Map<String, dynamic> map) {
    this.transactionId = map['transactionId'];
    this.key = map['key'];
    this.url = map['url'];
  }
}
