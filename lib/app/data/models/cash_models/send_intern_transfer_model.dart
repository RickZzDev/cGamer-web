import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';

class TransferSendModel {
  String? amount;
  String? password;
  String? identifier;
  String? description;

  TransferSendModel(
      {this.amount, this.password, this.identifier, this.description});

  TransferSendModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    password = json['password'];
    identifier = json['identifier'];
    description = json['description'];
  }

  // Map<String, String> fromTedInfoModelToJson(TedInfoModel tedInfoModel) {
  //   amount = SecurityUtils.encodeTo64(tedInfoModel.ammount);
  //   password = SecurityUtils.encodeTo64(tedInfoModel.password64);
  //   identifier = SecurityUtils.encodeTo64(tedInfoModel.userName);
  //   description = SecurityUtils.encodeTo64(tedInfoModel.description);
  //   return toJson();
  // }

  Map<String, dynamic> toJson(TedInfoModel? tedInfoModel) {
    this.amount = SecurityUtils.encodeTo64(tedInfoModel?.ammount ?? "");
    this.password = SecurityUtils.encodeTo64(tedInfoModel?.password64 ?? "");
    this.identifier = tedInfoModel?.userName == null
        ? SecurityUtils.encodeTo64(
            tedInfoModel?.cpf?.replaceAll('.', '').replaceAll('-', '') ?? "")
        : SecurityUtils.encodeTo64(tedInfoModel?.userName ?? "");
    this.description = description != null
        ? SecurityUtils.encodeTo64(tedInfoModel?.description ?? "")
        : null;
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['password'] = this.password;
    data['identifier'] = this.identifier;
    data['description'] = this.description;
    return data;
  }
}
