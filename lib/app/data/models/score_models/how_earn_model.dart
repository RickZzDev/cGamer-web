class HowEarnModel {
  List<HowEarnModelItem>? howEarns;

  HowEarnModel();

  HowEarnModel.fromJson(Map<String, dynamic> map) {
    if (map['howEarns'] != null) {
      howEarns = <HowEarnModelItem>[];
      map['howEarns'].forEach((v) {
        howEarns?.add(new HowEarnModelItem.fromJson(v));
      });
    }
  }
}

class HowEarnModelItem {
  String? iconUrl;
  String? title;
  String? description;
  String? earnPoints;
  String? action;

  HowEarnModelItem();

  HowEarnModelItem.fromJson(Map<String, dynamic> map) {
    this.iconUrl = map['iconUrl'];
    this.title = map['title'];
    this.description = map['description'];
    this.earnPoints = map['earnPoints'];
    this.action = map['action'];
  }
}
