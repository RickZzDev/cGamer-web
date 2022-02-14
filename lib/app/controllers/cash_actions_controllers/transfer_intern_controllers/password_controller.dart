import 'dart:convert';

import 'package:cGamer/app/data/models/cash_models/send_intern_transfer_model.dart';
import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/data/models/cash_models/transfer_response_model.dart';
import 'package:cGamer/app/data/repository/transfer_repositories/transfer_inter_repo.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/wallet_components/custom_body_widget.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class TransferPasswordController extends GetxController {
  final TransferInterRepository repository;

  TransferPasswordController({required this.repository});

  final formKey = GlobalKey<FormState>();
  String? value;
  String? type;
  bool contactSaved = false;
  TedInfoModel infoModel = TedInfoModel();
  TransferResponseModel _transferResponse = TransferResponseModel();
  TedInfoModel infoModelRequest = TedInfoModel();

  final inAssyncCall = false.obs;

  TextEditingController passwordController = TextEditingController();

  final moneyController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    precision: 2,
    initialValue: 00.00,
    leftSymbol: "R\$ ",
  ).obs;

  @override
  void onInit() {
    value = Get.arguments["value"];
    type = Get.arguments["type"] != null ? Get.arguments["type"] : null;
    contactSaved = Get.arguments['contact_saved'];
    infoModel =
        Get.arguments["ted_info"] != null ? Get.arguments["ted_info"] : null;
    super.onInit();
  }

  changeAssyncCall() => inAssyncCall.value = !inAssyncCall.value;

  changePage() {
    // GenericUtils.closeKeyoard(Get.context);
    changeAssyncCall();
    setPassword64();
    sendTransfer();
  }

  _mountObjToSend() {
    infoModelRequest.userName = infoModel.userName;
    infoModelRequest.description = infoModel.description;
    infoModelRequest.password64 = infoModel.password64;
    infoModelRequest.cpf = infoModel.cpf;
    moneyController.value.text = infoModel.ammount;
    double ammountDouble = moneyController.value.numberValue;
    infoModelRequest.ammount = ammountDouble.toString();
  }

  sendTransfer() async {
    _mountObjToSend();
    Map<String, dynamic> _toJson = TransferSendModel().toJson(infoModelRequest);
    var _response = await repository.transfer(_toJson);
    var exception = ExceptionUtils.verifyIfIsException(_response);
    if (exception) {
      changeAssyncCall();
      SnackBarUtils.showSnackBar(
          desc: _response.message,
          title: "Falha ao buscar",
          color: Colors.orange[400],
          icon: Icon(
            Icons.error,
            color: Colors.white,
          ));
    } else {
      _transferResponse =
          TransferResponseModel.fromJson(json.decode(_response.body));
      DartNotificationCenter.post(channel: 'refreshHome');
      realChange(_transferResponse);
      changeAssyncCall();
    }
  }

  realChange(TransferResponseModel _transferResponse) {
    Get.offNamedUntil(
      Routes.TRANSFER_SUCCESS,
      (route) => route.settings.name == Routes.MAIN_PAGES_HOLDER,
      arguments: {
        "type": type != null ? type : "transfer",
        "value": value,
        'ted_info': infoModel,
        'transfer_response': _transferResponse,
        "contact_saved": contactSaved
      },
    );
  }

  setPassword64() {
    infoModel.password64 = passwordController.text;
  }
}
