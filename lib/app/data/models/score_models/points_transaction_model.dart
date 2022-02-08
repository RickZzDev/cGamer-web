import 'package:cGamer/app/data/models/models_export.dart';

class PointsTransaction {
  String? title;
  int? points;
  String? description;
  String? date;
  String? operationType;

  PointsTransaction(
      {this.title,
      this.points,
      this.description,
      this.date,
      this.operationType});

  PointsTransaction.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    points = json['points'];
    description = json['description'];
    date = json['date'];
    operationType = json['operationType'];
  }
}

class PendentPointsTransaction {
  String? title;
  int? points;
  String? description;
  String? date;
  String? status;

  PendentPointsTransaction(
      {this.title, this.points, this.description, this.date, this.status});

  PendentPointsTransaction.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    points = json['points'];
    description = json['description'];
    date = json['date'];
    status = json['status'];
  }
}

class PointsTransactionModel {
  List<PendentPointsTransaction>? pendentPoints;
  List<PointsTransaction>? historyPoints;

  PointsTransactionModel({this.pendentPoints, this.historyPoints});

  PointsTransactionModel.fromJson(Map<String, dynamic> json) {
    if (json['historyPoints'] != null) {
      historyPoints = <PointsTransaction>[];
      json['historyPoints'].forEach((v) {
        historyPoints?.add(new PointsTransaction.fromJson(v));
      });
    }

    if (json['pendingPoints'] != null) {
      pendentPoints = <PendentPointsTransaction>[];
      json['pendingPoints'].forEach((v) {
        pendentPoints?.add(new PendentPointsTransaction.fromJson(v));
      });
    }
  }
}
