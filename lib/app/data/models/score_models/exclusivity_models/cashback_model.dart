import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/foundation.dart';

class CashBackModel {
  List<CashBackProduct>? cashback;

  CashBackModel.fromMap(Map<String, dynamic> map) {
    if (map['cashback'] != null) {
      cashback = <CashBackProduct>[];
      map['cashback'].forEach((v) {
        cashback?.add(CashBackProduct.fromMap(v));
      });
    }
  }
}

class CashBackProduct {
  int? id;
  String? title;
  String? iconProductUrl;
  double? points;

  CashBackProduct.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.iconProductUrl = map['iconProductUrl'];
    this.points = map['points'];
  }
}

class CashbackPurchaseModel {
  String? password;
  int? productId;
  CashbackPurchaseModel({required this.password, required this.productId});
  Map<String, dynamic> toJson() {
    return {
      "password": SecurityUtils.encodeTo64(password ?? ""),
      "productId": productId
    };
  }
}
