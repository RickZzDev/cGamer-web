class VirtualCardTransactionsModel {
  List<VirtualCardTransaction>? transactions;

  VirtualCardTransactionsModel({this.transactions});

  VirtualCardTransactionsModel.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = <VirtualCardTransaction>[];
      json['transactions'].forEach((v) {
        transactions?.add(new VirtualCardTransaction.fromJson(v));
      });
    }
  }
}

class VirtualCardTransaction {
  String? amount;
  String? title;
  String? description;
  String? date;
  String? iconUrl;
  String? type;

  VirtualCardTransaction(
      {this.amount, this.title, this.date, this.description});

  VirtualCardTransaction.fromJson(Map<String, dynamic> json) {
    this.amount = json['amount'];
    this.title = json['title'];
    this.description = json['description'];
    this.type = json['type'];
    this.iconUrl = json['iconUrl'];
    //this.authorizationCode = json['authorizationCode'];
    this.date = json['date'];
  }
}
