class AvatarModel {
  List<Avatars>? avatars;

  AvatarModel({this.avatars});

  AvatarModel.fromJson(Map<String, dynamic> json) {
    if (json['avatars'] != null) {
      avatars = <Avatars>[];
      json['avatars'].forEach((v) {
        avatars?.add(new Avatars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.avatars != null) {
      data['avatars'] = this.avatars?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Avatars {
  int? id;
  String? image;
  bool? select;

  Avatars({this.id, this.image, this.select});

  Avatars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    select = json['select'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['select'] = this.select;
    return data;
  }
}
