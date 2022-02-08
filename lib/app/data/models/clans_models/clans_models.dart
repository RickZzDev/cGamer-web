import 'package:flutter/widgets.dart';

class ClanPageModel {
  List<ClanModel>? clans;

  ClanPageModel.fromJson(Map<String, dynamic> json) {
    if (json['clans'] != null) {
      clans = [];

      json['clans'].forEach((object) {
        clans?.add(new ClanModel.fromJson(object));
      });
    }
  }
}

class ClanModel {
  int? id;
  String? name;
  int? qtdTrophy;
  String? image;
  int? qtdMembers;

  ClanModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.qtdTrophy = json['qtdTrophy'];
    json['image'] == null ? DoNothingAction() : this.image = json['image'];
    this.qtdMembers = json['qtdMembers'];
  }
}

class CreateClanModel {
  String? name;
  String? description;
  String? image;
  String? roomId;

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "description": this.description,
      "image": this.image,
      "roomId": this.roomId
    };
  }
}

class ClanInfoModel {
  int? clanId;

  ClanInfoModel.fromJson(Map<String, dynamic> json) {
    this.clanId = json['clanId'];
  }
}
