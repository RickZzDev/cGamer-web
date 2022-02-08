import 'package:flutter/material.dart';

class ClanRequestEntryModel {
  List<ClanRequestMembers>? members;

  ClanRequestEntryModel.fromJson(Map<String, dynamic> json) {
    if (json['requestEntries'] != null) {
      this.members = <ClanRequestMembers>[];

      json['requestEntries'].forEach(
          (object) => this.members?.add(ClanRequestMembers.fromJson(object)));
    }
  }
}

class ClanRequestMembers {
  int? customerId;
  String? name;
  String? username;
  String? avatarUrl;

  ClanRequestMembers.fromJson(Map<String, dynamic> json) {
    this.customerId = json['customerId'];
    this.name = json['name'];
    this.username = json['username'];
    this.avatarUrl = json['avatar'];
  }
}
