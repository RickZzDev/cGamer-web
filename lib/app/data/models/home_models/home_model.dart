import 'package:cGamer/app/data/models/models_export.dart';

class HomeModel {
  String? customerNick;
  Level? level;
  String? customerEmail;
  Badge? badge;
  String? customerAvatar;
  bool isPrime = false;
  bool isEmbaixador = false;
  int? totalInvites;

  HomeModel(
      {this.customerNick,
      this.level,
      this.customerEmail,
      this.badge,
      this.customerAvatar,
      this.totalInvites});

  HomeModel.fromJson(Map<String, dynamic> json) {
    isPrime = json['isPrime'];
    isEmbaixador = json['isEmbaixador'] ?? false;
    totalInvites = json['totalInvites'] ?? 0;

    customerNick = json['customerNick'];
    customerAvatar = json['customerAvatar'];
    customerEmail = json['customerEmail'] != null ? json['customerEmail'] : "";
    level = json['customerLevel'] != null
        ? new Level.fromJson(json['customerLevel'])
        : Level();
    badge = json['customerBadge'] != null
        ? Badge.fromJson(json['customerBadge'])
        : null;
  }
}

class Level {
  String? customerLevel = "";
  double? customerPoints = 0;
  double? customerPendentPoints = 0;
  double? nextLevelPoints = 0;
  double? customerBalancePoints = 0;
  String? nextLevel = "";
  String? iconLevelUrl = "";
  int? customerLevelId = 0;
  String? frameUrl = "";
  String? newFrameUrl = "";

  Level(
      {this.customerLevel,
      this.customerPoints,
      this.nextLevelPoints,
      this.nextLevel,
      this.customerBalancePoints,
      this.customerPendentPoints,
      this.customerLevelId,
      this.iconLevelUrl,
      this.frameUrl,
      this.newFrameUrl});

  Level.fromJson(Map<String, dynamic> json) {
    frameUrl = json['frameUrl'] != null ? json['frameUrl'] : "";
    customerLevel = json['customerLevel'];
    newFrameUrl = json['newFrameUrl'];
    customerPoints = json['customerPoints'];
    customerPendentPoints = json['customerPendentPoints'] != null
        ? double.parse(json['customerPendentPoints'].toString())
        : 0.0;
    nextLevelPoints =
        json['nextLevelPoints'] != null ? json['nextLevelPoints'] : 0;
    nextLevel = json['nextLevel'];
    customerBalancePoints = json['customerBalancePoints'];
    customerLevelId = json['customerLevelId'];
    iconLevelUrl = json['iconLevelUrl'];
  }
}
