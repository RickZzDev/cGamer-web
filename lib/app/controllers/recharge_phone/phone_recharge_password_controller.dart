import 'package:cGamer/app/data/models/recharge_phone/phone_recharge_model.dart';
import 'package:cGamer/app/data/repository/recharge_phone/phone_recharge_password_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/wallet_components/custom_body_widget.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class PhoneRechargePasswordController extends GetxController {
  final RechargePhonePasswordRepository repository;
  PhoneRechargePasswordController({required this.repository});

  final formKey = GlobalKey<FormState>();
  String? value;
  String? type;
  PhoneRechargeModel model = PhoneRechargeModel();

  final inAssyncCall = false.obs;

  TextEditingController passwordController = TextEditingController();
  MaskedTextController phoneController =
      MaskedTextController(mask: '00000000000');
  String phoneWithMask = "";

  @override
  void onInit() {
    value = Get.arguments["value"];
    type = Get.arguments["type"] != null ? Get.arguments["type"] : null;
    model = Get.arguments["phone_recharge_info"] != null
        ? Get.arguments["phone_recharge_info"]
        : null;
    phoneWithMask = model.phone ?? "";
    super.onInit();
  }

  changeAssyncCall() => inAssyncCall.value = !inAssyncCall.value;

  changePage() {
    // GenericUtils.closeKeyoard(Get.context);
    changeAssyncCall();
    setPassword64();
    sendTransfer();
  }

  sendTransfer() async {
    phoneController.value = TextEditingValue(text: model.phone ?? "");
    var phone = phoneController.value.text;
    model.phone = phone;
    var _response = await repository.finish(model);
    var exception = ExceptionUtils.verifyIfIsException(_response);
    if (exception) {
      changeAssyncCall();
      SnackBarUtils.showSnackBar(
          desc: _response.message,
          title: "Atenção",
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ));
    } else {
      DartNotificationCenter.post(channel: 'refreshHome');
      realChange();
      changeAssyncCall();
    }
  }

  realChange() {
    model.phone = phoneWithMask;
    Get.toNamed(
      Routes.RECHARGE_PHONE_SUCCESS,
      arguments: {
        'phone_recharge_model': model,
      },
    );
  }

  setPassword64() {
    model.password64 = passwordController.text;
  }
}
