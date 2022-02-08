class PhoneRechargeValuesModel {
  List<PhoneProviderValueModel>? values;
  PhoneRechargeValuesModel({this.values});

  PhoneRechargeValuesModel.fromJson(Map<String, dynamic> json) {
    if (json['values'] != null) {
      values = <PhoneProviderValueModel>[];
      json['values'].forEach((v) {
        values?.add(PhoneProviderValueModel.fromJson(v));
      });
    }
  }
}

class PhoneProviderValueModel {
  String? productId;
  String? name;
  double? amount;
  String? ammountFormatted;

  PhoneProviderValueModel(
      {this.productId, this.name, this.amount, this.ammountFormatted});

  PhoneProviderValueModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    name = json['name'];
    amount = json['amount'];
    ammountFormatted = json['amountFormatted'];
  }
}
