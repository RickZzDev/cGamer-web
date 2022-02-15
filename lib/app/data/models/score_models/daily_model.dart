import 'package:flutter/material.dart';

class DailyModel {
  DailyModel({@required this.title, this.points, this.checked, this.id});

  String? title;
  int? id;
  bool? checked;
  double? points;

  DailyModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    checked = json['checked'];
    points = json['points'];
  }
}

class DaysModel {
  DaysModel({this.days});

  List<DailyModel>? days;

  DaysModel.fromJson(Map<String, dynamic> json) {
    if (json['days'] != null) {
      days = <DailyModel>[];
      json['days'].forEach((v) {
        days?.add(new DailyModel.fromJson(v));
      });
    }
  }
}
