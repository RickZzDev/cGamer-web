import 'package:cGamer/app/data/models/models_export.dart';

class UserRankingModel {
  String? username;
  double? points;
  String? iconLevelUrl;
  int? customerPosition;
  Badge? badge;
  String? nickColor;

  UserRankingModel({this.username, this.points, this.iconLevelUrl});

  UserRankingModel.fromJson(Map<String, dynamic> json) {
    badge = json['customerBadge'] != null
        ? Badge.fromJson(json['customerBadge'])
        : null;
    username = json['customerUsername'];
    points = json['customerPoints'];
    iconLevelUrl = json['iconLevelUrl'];
    customerPosition = json['customerPosition'];
    nickColor = json['customerNickColor'];
  }
}

class RankingModel {
  List<UserRankingModel>? ranking;
  UserRankingModel? userRanking;

  RankingModel({this.ranking});

  RankingModel.fromJson(Map<String, dynamic> json) {
    userRanking = json['customerRanking'] != null
        ? new UserRankingModel.fromJson(json['customerRanking'])
        : null;
    if (json['ranking'] != null) {
      ranking = <UserRankingModel>[];
      json['ranking'].forEach((v) {
        ranking?.add(new UserRankingModel.fromJson(v));
      });
    }
  }
}
