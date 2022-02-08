import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:flutter/material.dart';

class GiftCardModel {
  List<GiftCardItemModel>? giftcards;
  GiftCardModel();
  GiftCardModel.fromJson(Map<String, dynamic> map) {
    if (map['giftcards'] != null) {
      giftcards = <GiftCardItemModel>[];
      map['giftcards'].forEach((giftcard) {
        giftcards?.add(GiftCardItemModel.fromMap(giftcard));
      });
    }
  }
}

class GiftCardItemModel {
  int? id;
  String? title;
  String? description;
  String? iconUrl;
  String? createdAt;
  List<GiftCardProducts>? products;

  GiftCardItemModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.iconUrl = map['iconUrl'];
    this.createdAt = map['createdAt'];
    if (map['products'] != null) {
      products = <GiftCardProducts>[];
      map['products'].forEach((product) {
        products?.add(GiftCardProducts.fromMap(product));
      });
    }
  }
}

class GiftCardProducts {
  int? id;
  String? title;
  String? iconProductUrl;
  String? createdAt;
  double? points;

  GiftCardProducts(
      {this.id, this.title, this.iconProductUrl, this.points}); //remove
  GiftCardProducts.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.createdAt = map['createdAt'];
    this.iconProductUrl = map['iconProductUrl'];
    this.points = map['points'];
  }
}

class GiftCardPurchaseModel {
  String? password;
  int? productId;

  GiftCardPurchaseModel({required this.password, required this.productId});

  Map<String, dynamic> toJson() {
    return {
      "password": SecurityUtils.encodeTo64(this.password ?? ""),
      "productId": this.productId
    };
  }
}
