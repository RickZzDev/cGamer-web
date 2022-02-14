class TransferExternSuccessResponse {
  FromCustomer? fromCustomer;
  ToCustomer? toCustomer;
  String? authenticationCode;

  TransferExternSuccessResponse(
      {this.fromCustomer, this.toCustomer, this.authenticationCode});

  TransferExternSuccessResponse.fromJson(Map<String, dynamic> json) {
    fromCustomer = json['fromCustomer'] != null
        ? new FromCustomer.fromJson(json['fromCustomer'])
        : null;
    toCustomer = json['toCustomer'] != null
        ? new ToCustomer.fromJson(json['toCustomer'])
        : null;
    authenticationCode = json['authenticationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fromCustomer != null) {
      data['fromCustomer'] = this.fromCustomer?.toJson();
    }
    if (this.toCustomer != null) {
      data['toCustomer'] = this.toCustomer?.toJson();
    }
    data['authenticationCode'] = this.authenticationCode;
    return data;
  }
}

class FromCustomer {
  String? customerName;
  String? customerNick;
  CustomerAccount? customerAccount;

  FromCustomer({this.customerName, this.customerNick, this.customerAccount});

  FromCustomer.fromJson(Map<String, dynamic> json) {
    customerName = json['customerName'];
    customerNick = json['customerNick'];
    customerAccount = json['customerAccount'] != null
        ? new CustomerAccount.fromJson(json['customerAccount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['customerNick'] = this.customerNick;
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

class ToCustomer {
  String? customerName;
  String? customerDocument;

  ToCustomer({this.customerName, this.customerDocument});

  ToCustomer.fromJson(Map<String, dynamic> json) {
    customerName = json['customerName'];
    customerDocument = json['customerDocument'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['customerDocument'] = this.customerDocument;
    return data;
  }
}
