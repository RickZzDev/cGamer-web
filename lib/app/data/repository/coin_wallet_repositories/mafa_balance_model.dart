class MafaBalanceModel {
  double balanceAvailable = 0;
  String currentCoinValueFormatted = '';
  double currentCoinValue = 0;
  String totalBalance = '';
  MafaBalanceModel();

  MafaBalanceModel.fromJson(Map<String, dynamic> json) {
    balanceAvailable = json['balanceAvailable'];
    currentCoinValueFormatted = json['currentCoinValueFormatted'];
    currentCoinValue = json['currentCoinValue'];
    totalBalance = json['totalBalance'];
  }
}

class PayWithPixModel {
  String pixCopyPaste = '';
  String orderId = '';
  String pixImage = '';
  PayWithPixModel();

  PayWithPixModel.fromJson(Map<String, dynamic> json) {
    pixCopyPaste = json['pixCopyPaste'];
    orderId = json['orderId'];
    pixImage = json['pixImage'];
  }
}

class PayWithPixRequest {
  double amount = 0.0;
  PayWithPixRequest();

  Map<String, dynamic> toJson() {
    return {
      "amount": this.amount,
    };
  }
}

class PayWithPixConfirmModel {
  bool status = false;

  PayWithPixConfirmModel();

  PayWithPixConfirmModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }
}
