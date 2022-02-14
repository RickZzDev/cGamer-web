class ExtractModel {
  List<TransactionExtract>? transactions;

  ExtractModel({this.transactions});

  ExtractModel.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = [];
      json['transactions'].forEach((v) {
        transactions?.add(new TransactionExtract.fromJson(v));
      });
    }
  }
}

class TransactionExtract {
  String? id;
  String? title;
  String? description;
  String? date;
  String? iconUrl;
  String? amount;
  String? type;
  String? typeTransaction;
  Details? details;

  TransactionExtract(
      {this.id,
      this.title,
      this.description,
      this.date,
      this.type,
      this.typeTransaction,
      this.amount,
      this.iconUrl,
      this.details});

  TransactionExtract.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    iconUrl = json['iconUrl'];
    date = json['date'];
    type = json['type'];
    amount = json['amount'];
    typeTransaction = json['typeTransaction'];

    if (json['details'] != null) {
      details = Details();
      details = Details.fromJson(json['details']);
    }
  }
}

class Details {
  String? transactionId;
  String? value;
  String? payer;
  String? agency;
  String? account;
  Destination? destination;
  FromCustomer? fromCustomer;

  Details();
  Details.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    value = json['value'];
    payer = json['payer'];
    agency = json['agency'];
    account = json['account'];

    if (json['destination'] != null) {
      destination = Destination.fromJson(json['destination']);
    }

    if (json['fromCustomer'] != null) {
      fromCustomer = FromCustomer.fromJson(json['fromCustomer']);
    }
  }
}

class Destination {
  String? name;
  String? document;
  String? bankName;
  String? agency;
  String? account;
  String? digitable;
  Destination();
  Destination.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    document = json['document'];
    bankName = json['bankName'];
    agency = json['agency'];
    account = json['account'];
    digitable = json['digitable'];
  }
}

class FromCustomer {
  String? name;
  String? bankName;
  String? agency;
  String? account;
  String? document;

  FromCustomer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bankName = json['bankName'];
    agency = json['agency'];
    account = json['account'];
    document = json['document'];
  }
}
