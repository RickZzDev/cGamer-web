class LastMafaMovimentsModel {
  List<Transactions>? transactions;
  bool hasMoviments = false;

  LastMafaMovimentsModel({this.transactions});

  LastMafaMovimentsModel.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      hasMoviments = true;
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? transactionId;
  String? date;
  String? image;
  String? title;
  String? description;
  String? walletId;
  String? ammount;

  Transactions(
      {this.transactionId,
      this.date,
      this.image,
      this.title,
      this.description});

  Transactions.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    date =
        '${json['date'].toString().split('/')[0]}/${json['date'].toString().split('/')[1]}';
    image = json['image'];
    title = json['title'];
    description = json['description'];
    if (json['destinationId'] != null) {
      walletId = 'Carteira de destino: ${json['destinationId']}';
    }
    if (json['amount'] != null) {
      ammount = json['amount'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = this.transactionId;
    data['date'] = this.date;
    data['image'] = this.image;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
