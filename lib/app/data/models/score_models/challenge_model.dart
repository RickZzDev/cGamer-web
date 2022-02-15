import 'package:flutter/material.dart';

class ChallengeModel {
  ChallengeModel(
      {@required this.title,
      this.description,
      this.points,
      this.imagePath,
      this.deepLink,
      this.hasCompleted,
      this.info});

  String? title;
  String? description;
  bool? hasCompleted;
  String? imagePath;
  double? points;
  String? deepLink;
  String? info;

  ChallengeModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imagePath = json['imageUrl'];
    deepLink = json['deepLink'];
    points = json['points'];
    hasCompleted = json['hasCompleted'];
    info = json['info'];
  }
}

class ChallengesModel {
  ChallengesModel({this.challenges});

  List<ChallengeModel>? challenges;

  ChallengesModel.fromJson(Map<String, dynamic> json) {
    if (json['actions'] != null) {
      challenges = <ChallengeModel>[];
      json['actions'].forEach((v) {
        challenges?.add(new ChallengeModel.fromJson(v));
      });
    }
  }
}
