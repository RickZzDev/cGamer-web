import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';

class DigitalCollectionsModel {
  List<DigitalCollectionModel>? products;

  DigitalCollectionsModel();

  DigitalCollectionsModel.fromJson(Map<String, dynamic> json) {
    products = <DigitalCollectionModel>[];
    json['partners'].forEach((v) {
      products?.add(new DigitalCollectionModel.fromJson(v));
    });
  }
}

class DigitalCollectionModel {
  int? id;
  String? name;
  String? image;
  String? offMessage;

  DigitalCollectionModel();

  DigitalCollectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    offMessage = json['offMessage'];
  }
}

class DigitalCollection {
  int? id;
  String? name;
  String? description;
  String? image;
  List<DigitalProduct>? products;

  DigitalCollection.fromJson(Map<String, dynamic> map) {
    products = <DigitalProduct>[];
    id = map['id'];
    name = map['name'];
    description = map['description'];
    image = map['image'];
    map['products'].forEach((v) => products?.add(DigitalProduct.fromJson(v)));
  }
}
