class ContactsExeternListModel {
  List<LastContacts>? lastContacts;
  List<ExternAllContacts>? allContacts;

  ContactsExeternListModel({this.lastContacts, this.allContacts});

  ContactsExeternListModel.fromJson(Map<String, dynamic> json) {
    if (json['lastContacts'] != null) {
      lastContacts = <LastContacts>[];
      json['lastContacts'].forEach((v) {
        lastContacts?.add(new LastContacts.fromJson(v));
      });
    }
    if (json['allContacts'] != null) {
      allContacts = <ExternAllContacts>[];
      json['allContacts'].forEach((v) {
        allContacts?.add(new ExternAllContacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lastContacts != null) {
      data['lastContacts'] = this.lastContacts?.map((v) => v.toJson()).toList();
    }
    if (this.allContacts != null) {
      data['allContacts'] = this.allContacts?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastContacts {
  String? name;
  String? typeTransfer;
  CustomerAccount? customerAccount;

  LastContacts({this.name, this.typeTransfer, this.customerAccount});

  LastContacts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    typeTransfer = json['typeTransfer'];
    customerAccount = json['customerAccount'] != null
        ? new CustomerAccount.fromJson(json['customerAccount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['typeTransfer'] = this.typeTransfer;
    if (this.customerAccount != null) {
      data['customerAccount'] = this.customerAccount?.toJson();
    }
    return data;
  }
}

class CustomerAccount {
  int? bankCode;
  String? bank;
  String? agency;
  String? account;

  CustomerAccount({this.bankCode, this.bank, this.agency, this.account});

  CustomerAccount.fromJson(Map<String, dynamic> json) {
    bankCode = json['bankCode'];
    bank = json['bank'];
    agency = json['agency'];
    account = json['account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankCode'] = this.bankCode;
    data['bank'] = this.bank;
    data['agency'] = this.agency;
    data['account'] = this.account;
    return data;
  }
}

class ExternAllContacts {
  String? name;
  List<Accounts>? accounts;

  ExternAllContacts({this.name, this.accounts});

  ExternAllContacts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['accounts'] != null) {
      accounts = <Accounts>[];
      json['accounts'].forEach((v) {
        accounts?.add(new Accounts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.accounts != null) {
      data['accounts'] = this.accounts?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Accounts {
  int? bankCode;
  String? bank;
  String? agency;
  String? account;

  Accounts({this.bankCode, this.bank, this.agency, this.account});

  Accounts.fromJson(Map<String, dynamic> json) {
    bankCode = json['bankCode'];
    bank = json['bank'];
    agency = json['agency'];
    account = json['account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankCode'] = this.bankCode;
    data['bank'] = this.bank;
    data['agency'] = this.agency;
    data['account'] = this.account;
    return data;
  }
}
