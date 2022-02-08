import 'package:cGamer/app/utils/generic_utils/security_utils.dart';

class ClanRouletteModel {
  late int pointsForDuplicate;

  late List values;

  ClanRouletteModel();

  ClanRouletteModel.fromJson(Map<String, dynamic> json) {
    this.pointsForDuplicate = json['pointsForDuplicate'];

    if (json['values'] != null) {
      values = [];
      values = json['values'];
    }
  }
}

class PlayRouletteRequestModel {
  String? value;
  bool? payPoints;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = SecurityUtils.encodeTo64(this.value ?? "");
    data['payPoints'] = this.payPoints;
    return data;
  }
}
