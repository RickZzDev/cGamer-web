class MyBadge {
  String? title;
  String? image;
  String? description;
  int? id;
  bool? isActive = false;

  MyBadge.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    id = json['id'];
    isActive = json['isActive'];
  }
}

class MyBadgesModel {
  List<MyBadge>? badges;

  MyBadgesModel({this.badges});

  MyBadgesModel.fromJson(Map<String, dynamic> json) {
    if (json['customerBadges'] != null) {
      badges = <MyBadge>[];
      json['customerBadges'].forEach((v) {
        badges?.add(new MyBadge.fromJson(v));
      });
    }
  }
}

class MyBadgeModelRequest {
  int? id;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['badgeId'] = id;
    return data;
  }
}
