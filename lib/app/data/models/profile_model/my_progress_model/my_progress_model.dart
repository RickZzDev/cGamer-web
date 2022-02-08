class LevelsModel {
  int? currentLevel;
  List<AllLevelModel>? levels;

  LevelsModel({this.currentLevel, this.levels});

  LevelsModel.fromJson(Map<String, dynamic> json) {
    currentLevel = json['currentLevel'];

    if (json['levels'] != null) {
      levels = <AllLevelModel>[];
      json['levels'].forEach((v) {
        levels?.add(new AllLevelModel.fromJson(v));
      });
    }
  }
}

class AllLevelModel {
  String? customerLevel = "";
  double? customerPoints = 0;
  bool? unlocked;
  List<dynamic>? benefits = [];
  double? multiplyPoints;
  String? multiplyPointsText;
  String? iconUrl;

  AllLevelModel(
      {this.customerLevel, this.customerPoints, this.unlocked, this.benefits});

  AllLevelModel.fromJson(Map<String, dynamic> json) {
    customerLevel = json['level'];
    customerPoints = json['qtdPoints'];
    unlocked = json['unlocked'];
    benefits = json['benefits'];
    multiplyPoints = json['multiplyPoints'];
    multiplyPointsText = json['multiplyPointsText'];
    iconUrl = json['iconUrl'];
  }
}
