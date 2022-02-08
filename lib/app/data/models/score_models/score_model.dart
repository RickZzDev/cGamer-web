import 'package:cGamer/app/data/models/home_models/home_model.dart';

class ScoreModel {
  String? multiplyPointsText;
  Level? customerLevel;

  ScoreModel({
    this.multiplyPointsText,
    this.customerLevel,
  });

  ScoreModel.fromJson(Map<String, dynamic> json) {
    multiplyPointsText =
        json['multiplyPointsText'] != null ? json['multiplyPointsText'] : null;
    customerLevel = json['customerLevel'] != null
        ? new Level.fromJson(json['customerLevel'])
        : null;
  }
}
