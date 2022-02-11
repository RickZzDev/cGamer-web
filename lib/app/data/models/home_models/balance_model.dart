class BalanceModel {
  BalanceAvailable? balanceAvailable;
  BalanceAvailable? balanceInProcess;
  BalanceAvailable? balanceBlocked;

  BalanceModel(
      {this.balanceAvailable, this.balanceInProcess, this.balanceBlocked});

  BalanceModel.fromJson(Map<String, dynamic> json) {
    balanceAvailable = json['balanceAvailable'] != null
        ? new BalanceAvailable.fromJson(json['balanceAvailable'])
        : null;
    balanceInProcess = json['balanceInProcess'] != null
        ? new BalanceAvailable.fromJson(json['balanceInProcess'])
        : null;
    balanceBlocked = json['balanceBlocked'] != null
        ? new BalanceAvailable.fromJson(json['balanceBlocked'])
        : null;
  }
}

class BalanceAvailable {
  String? available;

  BalanceAvailable({this.available});

  BalanceAvailable.fromJson(Map<String, dynamic> json) {
    available = json['available'];
  }
}
