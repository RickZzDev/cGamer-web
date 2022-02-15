import 'package:flutter/material.dart';

class ClanDetailsModel {
  String? name;
  String? image;
  String? description;
  int? qtdMembers;
  int? qtdTrophy;
  List<ClanDetailsMembers>? members;
  List<Iteration>? iterations;
  bool? isAdmin = false;
  bool? isMember = false;
  bool? isRequested = false;
  String? roomId;

  ClanDetailsModel.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    json['image'] != null ? this.image = json['image'] : DoNothingAction();
    this.description = json['description'];
    this.qtdMembers = json['qtdMembers'];
    this.qtdTrophy = json['qtdTrophy'];
    this.roomId = json['roomId'];

    this.isAdmin = json['isAdmin'] ?? false;
    this.isMember = json['isMember'] ?? false;
    this.isRequested = json['isRequested'] ?? false;

    if (json['members'] != null) {
      this.members = <ClanDetailsMembers>[];

      json['members'].forEach(
          (object) => this.members?.add(ClanDetailsMembers.fromJson(object)));
    }

    if (json['iterations'] != null) {
      this.iterations = <Iteration>[];
      json['iterations'].forEach(
          (object) => this.iterations?.add(Iteration.fromJson(object)));
    }
  }
}

class Iteration {
  String? name;
  bool? enabled;

  Iteration.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.enabled = json['enabled'];
  }
}

class ClanDetailsMembers {
  int? customerId;
  String? name;
  String? username;
  String? role;
  String? avatarUrl;
  bool isPrime = false;
  bool isEmbaixador = false;
  int? qtdTrophy;

  ClanDetailsMembers.fromJson(Map<String, dynamic> json) {
    this.isPrime = json['isPrime'] ?? false;
    this.isEmbaixador = json['isEmbaixador'] ?? false;
    this.customerId = json['customerId'];
    this.name = json['name'];
    this.username = json['username'];
    this.role = json['role'];
    this.avatarUrl = json['avatar'];
    this.qtdTrophy = json['qtdTrophy'];
  }
}
