class TaxModel {
  dynamic tax;

  TaxModel({this.tax});

  TaxModel.fromJson(Map<String, dynamic> json) {
    tax = json['tax'];
  }
}
