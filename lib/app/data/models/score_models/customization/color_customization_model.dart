class ColorCustomizationModel {
  ColorCustomizationModel(
      {this.colors,
      this.priceColor,
      this.customerBalancePoints,
      this.customerUsername});

  double? customerBalancePoints;
  double? priceColor;
  String? customerUsername;
  List<String>? colors;

  ColorCustomizationModel.fromJson(Map<String, dynamic> map) {
    customerBalancePoints = map['customerBalancePoints'];
    customerUsername = map['customerUsername'];
    priceColor = map['priceColor'];
    if (map['colors'] != null) {
      colors = <String>[];
      map['colors'].forEach((obj) {
        colors?.add(obj);
      });
    }
  }
}
