import 'package:cGamer/app/data/models/recharge_phone/phone_provider_model.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';

class PhoneRechargeModel {
  String? nick;
  String? phone;
  String? valueFormatted;
  double? value;
  PhoneProvider? provider;
  String? rechargeDate;
  String? password64;
  String? productId;

  PhoneRechargeModel(
      {this.nick,
      this.phone,
      this.valueFormatted,
      this.value,
      this.provider,
      this.rechargeDate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nick'] = this.nick;
    data['phone'] = this.phone;
    data['value'] = this.value;
    data['productId'] = this.productId;
    data['password'] = SecurityUtils.encodeTo64(this.password64 ?? "");
    data['provider'] = this.provider?.name;
    return data;
  }
}
