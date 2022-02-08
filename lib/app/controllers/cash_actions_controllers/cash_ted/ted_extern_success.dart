import 'package:cGamer/app/data/data_exports.dart';
import 'package:cGamer/app/data/models/cash_models/save_contact_extern.dart';
import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/data/models/cash_models/transfer_response_model.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferExternSuccessController extends GetxController {
  final TransferExternRepository repository;
  TransferExternSuccessController({required this.repository});

  final inAssyncCall = false.obs;
  final contactSaved = false.obs;

  String type = Get.arguments["type"];
  String value = Get.arguments["value"];
  TedInfoModel infoModel =
      Get.arguments["ted_info"] != null ? Get.arguments["ted_info"] : null;
  TransferResponseModel responseTransfer =
      Get.arguments["transfer_response"] != null
          ? Get.arguments["transfer_response"]
          : null;

  @override
  void onInit() {
    type = Get.arguments["type"];
    value = Get.arguments["value"];
    infoModel =
        Get.arguments["ted_info"] != null ? Get.arguments["ted_info"] : null;
    // responseTransfer = Get.arguments["transfer_response"] != null
    // ? Get.arguments["transfer_response"]
    // : null;
    super.onInit();
  }

  saveContact() async {
    changeAssyncValue();

    Map<String, dynamic> saveContactMap =
        SaveExternContactModel().fromTedInfoModel(infoModel);
    var response = await repository.saveContact(saveContactMap);
    var exception = ExceptionUtils.verifyIfIsException(response);
    if (exception) {
      changeAssyncValue();
      showSnackBar(response.message);
    } else {
      contactSaved.value = true;
      changeAssyncValue();
    }
  }

  changeAssyncValue() => inAssyncCall.value = !inAssyncCall.value;

  showSnackBar(String message) => SnackBarUtils.showSnackBar(
        desc: message,
        title: "Falha ao adicionar",
        color: Colors.orange[400],
        icon: Icon(
          Icons.search_off,
          color: Colors.white,
        ),
      );
}
