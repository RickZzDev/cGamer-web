import 'package:cGamer/app/utils/api_utils/api_path.dart';

class RechargePhoneEndpoints {
  String contacts = "/recharge/phone/contacts";
  String providers = "/recharge/phone/providers";
  String finish = "/recharge/phone/finish";

  String values(String providerId) => "/recharge/phone/$providerId/values";
}
