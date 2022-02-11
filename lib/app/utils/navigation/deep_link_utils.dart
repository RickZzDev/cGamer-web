import 'package:cGamer/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DeepLinkUtils {
  final Function changeTabFunction;
  DeepLinkUtils(this.changeTabFunction);
  void defineDeepLink(String link) {
    switch (link) {
      case "add_cash":
        Get.toNamed(Routes.CHOOSE_DEPOSIT_WAY, arguments: {'type': "deposit"});
        break;
      case "recharge_phone":
        Get.toNamed(Routes.RECHARGE_PHONE_NUMBER);
        break;
      case "transfer_to_friend":
        Get.toNamed(Routes.CHOOSE_DEPOSIT_WAY, arguments: {'type': "transfer"});
        break;
      case "invite_friends":
        Get.toNamed(Routes.INVITE_FRIEND);
        break;
      case "marketplace":
        changeTabFunction(1);
        break;
      case "pay_bill":
        Get.toNamed(Routes.PAYMENT_READ_BAR_CODE);
        break;
      default:
        DoNothingAction();
    }
  }
}
