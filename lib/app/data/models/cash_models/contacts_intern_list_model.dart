import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'dart:convert';

class ContactsListModel {
  List<LastContacts>? lastContacts;
  List<AllContacts>? allContacts;
  String? accountType;

  ContactsListModel({this.lastContacts, this.allContacts});

  ContactsListModel.fromJson(Map<String, dynamic> json) {
    if (json['lastContacts'] != null) {
      lastContacts = <LastContacts>[];
      json['lastContacts'].forEach((v) {
        lastContacts?.add(new LastContacts.fromJson(v));
      });
    }
    if (json['allContacts'] != null) {
      allContacts = <AllContacts>[];
      json['allContacts'].forEach((v) {
        allContacts?.add(new AllContacts.fromJson(v));
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

  ContactsListModel.fromExternJson(Map<String, dynamic> json) {
    if (json['lastContacts'] != null) {
      lastContacts = <LastContacts>[];
      json['lastContacts'].forEach((v) {
        lastContacts?.add(new LastContacts.fromExternJson(v));
      });
    }
    if (json['allContacts'] != null) {
      allContacts = <AllContacts>[];
      json['allContacts'].forEach((v) {
        allContacts?.add(new AllContacts.fromExternJson(v));
      });
    }
  }
}

class LastContacts {
  String? customerName;
  String? customerUserName;
  String? name;
  String? typeTransfer;
  String? identifier;
  CustomerAccount? customerAccount;

  LastContacts({this.customerName, this.customerUserName});

  LastContacts.fromJson(Map<String, dynamic> json) {
    if (json['identifier'] != null) {
      this.identifier = SecurityUtils.decodeFrom64(json['identifier']);
    }
    customerName = utf8.decode(json['customerName'].toString().codeUnits);
    customerUserName = json['customerUserName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['customerUserName'] = this.customerUserName;
    return data;
  }

  LastContacts.fromExternJson(Map<String, dynamic> json) {
    if (json['identifier'] != null) {
      this.identifier = SecurityUtils.decodeFrom64(json['identifier']);
    }
    name = json['name'];
    typeTransfer = json['typeTransfer'];
    customerAccount = json['customerAccount'] != null
        ? new CustomerAccount.fromJson(json['customerAccount'])
        : null;
  }

  Map<String, dynamic> toExternJson() {
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
  String? accountType;

  CustomerAccount({this.bankCode, this.bank, this.agency, this.account});

  CustomerAccount.fromJson(Map<String, dynamic> json) {
    bankCode = json['bankCode'];
    bank = json['bank'];
    agency = json['agency'];
    account = json['account'];
    accountType = json["accountType"] != null
        ? json["accountType"] == "Conta Corrente"
            ? "CHECKING"
            : json["accountType"] == "Conta Poupança"
                ? "SAVINGS"
                : json["accountType"]
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankCode'] = this.bankCode;
    data['bank'] = this.bank;
    data['agency'] = this.agency;
    data['account'] = this.account;
    data['accountType'] = this.accountType;
    return data;
  }
}

class AllContacts {
  String? customerName;
  String? customerUserName;
  String? name;
  String? identifier;

  List<dynamic>? accounts;

  AllContacts({this.customerName, this.customerUserName});

  AllContacts.fromJson(Map<String, dynamic> json) {
    if (json['identifier'] != null) {
      this.identifier = SecurityUtils.decodeFrom64(json['identifier']);
    }
    customerName = utf8.decode(json['customerName'].toString().codeUnits);
    customerUserName = json['customerUserName'];
  }

  AllContacts.fromExternJson(Map<String, dynamic> json) {
    if (json['identifier'] != null) {
      this.identifier = SecurityUtils.decodeFrom64(json['identifier']);
    }
    name = json['name'];
    accounts = json['accounts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['customerUserName'] = this.customerUserName;
    return data;
  }
}

class Accounts {
  int? bankCode;
  String? bank;
  String? agency;
  String? account;
  String? accountType;

  Accounts({this.bankCode, this.bank, this.agency, this.account});

  Accounts.fromJson(Map<String, dynamic> json) {
    bankCode = json['bankCode'];
    bank = json['bank'];
    agency = json['agency'];
    account = json['account'];
    accountType = json['accountType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankCode'] = this.bankCode;
    data['bank'] = this.bank;
    data['agency'] = this.agency;
    data['account'] = this.account;
    data['accountType'] = this.accountType;
    return data;
  }
}

class PhoneContactsListModel {
  List<PhoneContact>? contacts;

  PhoneContactsListModel({this.contacts});

  PhoneContactsListModel.fromJson(Map<String, dynamic> json) {
    if (json['contacts'] != null) {
      contacts = <PhoneContact>[];
      json['contacts'].forEach((v) {
        contacts?.add(new PhoneContact.fromJson(v));
      });
    }
  }
}

class PhoneContact {
  String? phone;
  String? nick;

  PhoneContact({this.phone, this.nick});

  PhoneContact.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    nick = json['nick'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['nick'] = this.nick;
    return data;
  }
}
