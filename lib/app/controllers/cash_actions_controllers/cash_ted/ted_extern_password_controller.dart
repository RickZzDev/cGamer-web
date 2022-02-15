import 'package:cGamer/app/data/models/cash_models/send_extern_transfer_model.dart';
import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/data/models/cash_models/transfer_response_model.dart';
import 'package:cGamer/app/data/repository/transfer_repositories/transfer_extern_repo.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/generic_components/inputs/money_text_mask_custom.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferExternPasswordController extends GetxController {
  final TransferExternRepository repository;
  TransferExternPasswordController({required this.repository});

  final formKey = GlobalKey<FormState>();
  String? value;
  String? type;
  TedInfoModel infoModel = TedInfoModel();
  TedInfoModel infoModelRequest = TedInfoModel();

  // TransferResponseModel _transferResponse = TransferResponseModel();
  // TransferResponseModel _transferResponse = TransferResponseModel();

  final inAssyncCall = false.obs;

  TextEditingController passwordController = TextEditingController();
  final moneyController = MyMoneyMaskedTextController(
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
    infoModelRequest.accounType = infoModel.accounType;
    infoModelRequest.accountNumber = infoModel.accountNumber;
    infoModelRequest.agency = infoModel.agency;
    infoModelRequest.ammountWithTax = infoModel.ammountWithTax;
    infoModelRequest.bank = infoModel.bank;
    infoModelRequest.bankCode = infoModel.bankCode;
    infoModelRequest.cnpj = infoModel.cnpj;
    infoModelRequest.cpf = infoModel.cpf;
    infoModelRequest.description = infoModel.description;
    infoModelRequest.fullName = infoModel.fullName;
    infoModelRequest.password64 = infoModel.password64;
    moneyController.value.text = infoModel.ammount ?? "0.0";
    double ammountDouble = moneyController.value.numberValue;
    infoModelRequest.ammount = ammountDouble.toString();
    moneyController.value.text = infoModel.ammountWithTax ?? "0.0";
    double ammountWithTaxDouble = moneyController.value.numberValue;
    infoModelRequest.ammountWithTax = ammountWithTaxDouble.toString();
  }

  sendTransfer() async {
    _mountObjToSend();
    Map<String, dynamic> _toJson =
        SendExternTransferModel().fromTedInfoModelToJson(infoModelRequest);
    // print(_toJson);
    var _response = await repository.sendTransfer(_toJson);
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
      DartNotificationCenter.post(channel: 'refreshHome');
      realChange(_response);
      changeAssyncCall();
    }
  }

  realChange(TransferResponseModel _transferResponse) {
    Get.offAllNamed(
      Routes.TRANSFER_TED_EXTERN_SUCCESS,
      arguments: {
        "type": type != null ? type : "transfer",
        "value": value,
        'ted_info': infoModel,
        'transfer_response': _transferResponse
      },
    );
  }

  setPassword64() {
    infoModel.password64 = passwordController.text;
  }
}
