import 'dart:convert';

import 'package:cGamer/app/data/models/bill_payment/bill_payment_model.dart';
import 'package:cGamer/app/data/repository/bill_payment_repositories/bill_payment_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillPaymentPasswordController extends GetxController {
  final BillPaymentRepository repository;
  BillPaymentPasswordController({required this.repository});

  final formKey = GlobalKey<FormState>();
  String? value;
  String? type;
  BillPaymentValidateResponseModel model = BillPaymentValidateResponseModel();
  BillPaymentConfirmResponseModel responseModel =
      BillPaymentConfirmResponseModel();
  BillPaymentConfirmModel requestModel = BillPaymentConfirmModel();
  final inAssyncCall = false.obs;

  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    model = Get.arguments["bill_payment_model"] != null
        ? Get.arguments["bill_payment_model"]
        : null;
    super.onInit();
  }

  changeAssyncCall() => inAssyncCall.value = !inAssyncCall.value;

  changePage() {
    changeAssyncCall();
    sendPayment();
  }

  sendPayment() async {
    fillRequestModel();
    var _response = await repository.confirm(requestModel);
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
      responseModel = BillPaymentConfirmResponseModel.fromJson(
        json.decode(utf8.decode(_response.bodyBytes)),
      );

      responseModel.digitable = model.digitable;
      responseModel.amount = model.amount;
      responseModel.amountFormatted = model.amountFormatted;
      responseModel.dueDate = model.dueDate;
      responseModel.id = model.id;
      responseModel.recipient = model.recipient;
      responseModel.nextSettle = model.nextSettle;
      responseModel.originalAmount = model.originalAmount;

      changeAssyncCall();
      DartNotificationCenter.post(channel: 'refreshHome');
      Get.toNamed(
        Routes.PAYMENT_BILL_SUCCESS,
        arguments: {
          'bill_payment_model': responseModel,
        },
      );
    }
  }

  fillRequestModel() {
    requestModel.amount = model.amount;
    requestModel.id = model.id;
    requestModel.password64 = passwordController.text;
  }
}
