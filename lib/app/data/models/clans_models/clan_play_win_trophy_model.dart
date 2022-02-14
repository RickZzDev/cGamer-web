class PlayWinTrophyModel {
  List<PlayWinTrophyItem>? howEarns;
  int? balanceTrophy;

  PlayWinTrophyModel();

  PlayWinTrophyModel.fromJson(Map<String, dynamic> map) {
    balanceTrophy = map['balanceTrophy'];
    if (map['howEarns'] != null) {
      howEarns = <PlayWinTrophyItem>[];
      map['howEarns'].forEach((v) {
        howEarns?.add(new PlayWinTrophyItem.fromJson(v));
      });
    }
  }
}

class PlayWinTrophyItem {
  String? iconUrl;
  String? title;
  String? description;
  String? lastActionDate;
  String? action;
  String? buttonTitle;
  bool? containsCounter;

  PlayWinTrophyItem();

  PlayWinTrophyItem.fromJson(Map<String, dynamic> map) {
    this.iconUrl = map['iconUrl'];
    this.title = map['title'];
    this.description = map['description'];
    this.lastActionDate = map['lastActionDate'];
    this.action = map['action'];
    this.buttonTitle = map['buttonTitle'];
    this.containsCounter = map['containsCounter'];
  }
}
