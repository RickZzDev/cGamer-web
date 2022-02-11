import 'package:flutter/material.dart';

class ClanRankingModel {
  List<ClanRanking>? clans;
  ClanSeason? season;

  ClanRankingModel({this.clans, this.season});

  ClanRankingModel.fromJson(Map<String, dynamic> json) {
    if (json['clans'] != null) {
      this.clans = <ClanRanking>[];

      json['clans']
          .forEach((object) => this.clans?.add(ClanRanking.fromJson(object)));
    }

    if (json['season'] != null) {
      this.season = ClanSeason.fromJson(json['season']);
    }
  }
}

class MembersRankingModel {
  List<MemberRanking>? members;
  MemberSeason? season;

  MembersRankingModel({this.members, this.season});

  MembersRankingModel.fromJson(Map<String, dynamic> json) {
    if (json['members'] != null) {
      this.members = <MemberRanking>[];

      json['members'].forEach(
          (object) => this.members?.add(MemberRanking.fromJson(object)));
    }

    if (json['season'] != null) {
      this.season = MemberSeason.fromJson(json['season']);
    }
  }
}

class ClanRanking {
  String? name;
  String? image;
  int? id;
  int? qtdTrophy;
  int? qtdMembers;

  ClanRanking.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.image = json['image'];
    this.id = json['id'];
    this.qtdTrophy = json['qtdTrophy'];
    this.qtdMembers = json['qtdMembers'];
  }
}

class MemberRanking {
  String? name;
  String? avatar;
  int? id;
  String? username;
  String? claLogo;
  int? claId;
  String? claName;
  int? qtdTrophy;
  bool isPrime = false;
  bool isEmbaixador = false;

  MemberRanking.fromJson(Map<String, dynamic> json) {
    this.name = json['nick'];
    this.avatar = json['avatar'];
    this.id = json['id'];
    this.qtdTrophy = json['qtdTrophy'];
    this.username = json['username'];
    this.claLogo = json['cla_logo'];
    this.claId = json['cla_id'];
    this.claName = json['cla_name'];
    this.isPrime = json['isPrime'] ?? false;
    this.isEmbaixador = json['isEmbaixador'] ?? false;
  }
}

class ClanSeason {
  String? name;
  String? dateFinish;
  List<dynamic>? prize;

  ClanSeason(this.name, this.dateFinish, this.prize);

  ClanSeason.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.dateFinish = json['dateFinish'];
    this.prize = json['prize'];
  }
}

class MemberSeason {
  String? name;
  String? dateFinish;
  List<dynamic>? prize;

  MemberSeason(this.name, this.dateFinish, this.prize);

  MemberSeason.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.dateFinish = json['date_finish'];
    this.prize = json['prize_individual'];
  }
}
