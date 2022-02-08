import 'dart:convert';

import 'package:cGamer/app/data/models/bill_payment/bill_payment_model.dart';
import 'package:cGamer/app/data/repository/bill_payment_repositories/bill_payment_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class WriteBarCodeController extends GetxController {
  BillPaymentRepository repository;
  WriteBarCodeController({required this.repository});

  MaskedTextController textController = MaskedTextController(
      mask: '00000.00000 00000.000000 00000.000000 0 000000000000000');
  MaskedTextController codeWithoutMaskController = MaskedTextController(
      mask: '000000000000000000000000000000000000000000000000');
  BillPaymentValidateResponseModel responseModel =
      BillPaymentValidateResponseModel();

  final inAssyncCall = false.obs;
  bool isBackPortrait = false;

  @override
  void onInit() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    if (!isBackPortrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
      ]);
    }
    super.onClose();
  }

  changeAssyncCall() => inAssyncCall.value = !inAssyncCall.value;

  validateBarCode() async {
    changeAssyncCall();
    BillPaymentValidateModel requestModel = BillPaymentValidateModel();
    requestModel.isDigitable = true;
    codeWithoutMaskController.value =
        TextEditingValue(text: textController.value.text);
    requestModel.code = codeWithoutMaskController.value.text;
    var response = await repository.validate(requestModel);
    if (ExceptionUtils.verifyIfIsException(response)) {
      changeAssyncCall();
      SnackBarUtils.showSnackBar(
          desc: response.message != null && response.message != ""
              ? response.message
              : "Não foi possível buscar os dados para o pagamento deste boleto. Tente novamente mais tarde.",
          title: "Atenção");
    } else {
      changeAssyncCall();
      responseModel = BillPaymentValidateResponseModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      isBackPortrait = true;
      Get.toNamed(Routes.PAYMENT_BILL_CONFIRM,
          arguments: {'bill_payment_model': responseModel});
    }
  }

  bool validateField() {
    String barCode = textController.value.text;
    if (barCode.isNotEmpty && barCode.length >= 54) {
      return true;
    }
    return false;
  }
}
