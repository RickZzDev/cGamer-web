import 'package:cGamer/app/utils/generic_utils/security_utils.dart';

class BuyBadge {
  String? title;
  String? image;
  String? description;
  int? id;
  double? sellPoints;
  bool? isSelected = false;
  bool? hasContains = false;

  BuyBadge.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    id = json['id'];
    sellPoints = json['sellPoints'];
    hasContains = json['hasContains'];
  }
}

class BuyBadgeModel {
  List<BuyBadge>? badges;

  BuyBadgeModel({this.badges});

  BuyBadgeModel.fromJson(Map<String, dynamic> json) {
    if (json['badges'] != null) {
      badges = <BuyBadge>[];
      json['badges'].forEach((v) {
        badges?.add(new BuyBadge.fromJson(v));
      });
    }
  }
}

class BuyBadgeModelRequest {
  String? password;
  int? id;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = SecurityUtils.encodeTo64(this.password ?? "");
    data['badgeId'] = id;
    return data;
  }
}
