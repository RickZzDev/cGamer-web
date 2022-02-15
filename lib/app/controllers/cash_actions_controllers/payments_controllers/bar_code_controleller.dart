import 'dart:convert';

import 'package:cGamer/app/data/models/bill_payment/bill_payment_model.dart';
import 'package:cGamer/app/data/repository/bill_payment_repositories/bill_payment_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';

class ReadBarCodeController extends GetxController {
  BillPaymentRepository repository;
  ReadBarCodeController({required this.repository});

  MaskedTextController textController = MaskedTextController(
      mask: '00000.00000 00000.000000 00000.000000 0 00000000000000');
  BillPaymentValidateResponseModel responseModel =
      BillPaymentValidateResponseModel();

  var valorCodigoBarras = '';
  final loading = false.obs;

  @override
  void onReady() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);

    super.onReady();
  }

  validateBarCode(String barCode) async {
    loading.value = true;
    BillPaymentValidateModel requestModel = BillPaymentValidateModel();
    textController.value = TextEditingValue(text: barCode);
    requestModel.code = barCode;
    requestModel.isDigitable = false;
    var response = await repository.validate(requestModel);
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: response.message != null && response.message != ""
              ? response.message
              : "Não foi possível buscar os dados para o pagamento deste boleto. Tente novamente mais tarde.",
          title: "Atenção");
    } else {
      responseModel = BillPaymentValidateResponseModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      loading.value = false;
      Get.toNamed(Routes.PAYMENT_BILL_CONFIRM,
          arguments: {'bill_payment_model': responseModel});
    }
  }

  Future<bool> validateField(String? barCode) async {
    if (barCode != null &&
        barCode.isNotEmpty &&
        barCode.length >= 44 &&
        !loading.value) {
      print(barCode);
      await validateBarCode(barCode);
      return true;
    }
    return false;
  }
}
