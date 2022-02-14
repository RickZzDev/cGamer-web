class ProfileGamesModel {
  List<Games>? games;

  ProfileGamesModel({this.games});

  ProfileGamesModel.fromJson(Map<String, dynamic> json) {
    if (json['games'] != null) {
      games = <Games>[];
      json['games'].forEach((v) {
        games?.add(new Games.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.games != null) {
      data['games'] = this.games?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Games {
  int? id;
  String? name;
  String? image;
  bool? selected;

  Games({this.id, this.name, this.image, this.selected});

  Games.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['selected'] = this.selected;
    return data;
  }
}
