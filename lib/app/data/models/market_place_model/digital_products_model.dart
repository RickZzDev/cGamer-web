import 'package:cGamer/app/data/models/market_place_model/digital_collections_model.dart';

class DigitalProduct {
  int? id;
  String? name;
  String? image;
  double? salesPrice;
  String? partner;
  String? salesPriceFormatted;
  int? partnerId;
  double? points;
  DigitalProduct();

  DigitalProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    salesPrice = json['salesPrice'];
    partner = json['partner'];
    partnerId = json['partnerId'];
    points = json['points'];
    salesPriceFormatted = json['salesPriceFormatted'];
  }
}

class DigitalProducts {
  List<DigitalProduct>? products;
  List<DigitalCollection>? collections;
  DigitalProducts();
  DigitalProducts.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <DigitalProduct>[];
      json['products']
          .forEach((v) => products?.add(DigitalProduct.fromJson(v)));
    }

    if (json['collections'] != null) {
      collections = <DigitalCollection>[];
      json['collections']
          .forEach((v) => collections?.add(DigitalCollection.fromJson(v)));
    }
  }
}

class DigitalProductDetail {
  int? id;
  String? name;
  String? image;
  String? description;
  double? salesPrice;
  String? partner;
  String? salesPriceFormatted;
  String? termsAndConditions;
  String? howToRedeem;
  int? partnerId;

  DigitalProductDetail();

  DigitalProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    salesPrice = json['salesPrice'];
    termsAndConditions = json['termsAndConditions'];
    partner = json['partner'];
    howToRedeem = json['howToRedeem'];
    partnerId = json['partnerId'];
    salesPriceFormatted = json['salesPriceFormatted'];
  }
}
