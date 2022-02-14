class MarketplacePurchaseResponse {
  String? status;
  MarketplaceTransaction? transaction;
  String? id;
  String? pin;
  String? authorizationCode;
  String? nsu;

  MarketplacePurchaseResponse();

  MarketplacePurchaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    transaction = json['transaction'] != null
        ? MarketplaceTransaction.fromJson(json['transaction'])
        : null;
    pin = json['pin'];
    authorizationCode = json['authorization_code'];
    id = json['id'];
    nsu = json['nsu'];
  }
}

class MarketplaceTransaction {
  String? transactionId;
  String? key;
  String? url;

  MarketplaceTransaction();

  MarketplaceTransaction.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    key = json['key'];
    url = json['url'];
  }
}
