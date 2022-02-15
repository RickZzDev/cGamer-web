class MissionsModel {
  List<Missions>? missions;

  MissionsModel({this.missions});

  MissionsModel.fromJson(Map<String, dynamic> json) {
    if (json['missions'] != null) {
      missions = <Missions>[];
      json['missions'].forEach((v) {
        missions?.add(new Missions.fromJson(v));
      });
    }
  }
}

class Missions {
  int? id;
  String? name;
  double? points;
  bool hasComplete = false;
  String? imgName;
  String? iconUrl;
  String? deepLink;

  Missions(
      {this.id,
      this.name,
      this.points,
      this.hasComplete = false,
      this.deepLink});

  Missions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    points = json['points'];
    iconUrl = json['iconURL'];
    hasComplete = json['hasComplete'];
    deepLink = json['deepLink'];
  }
}
