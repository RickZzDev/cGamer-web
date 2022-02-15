import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/data/models/cash_models/transfer_response_model.dart';
import 'package:cGamer/app/data/repository/transfer_repositories/transfer_inter_repo.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class TransferConfirmSuccessController extends GetxController {
  final TransferInterRepository repository;
  TransferConfirmSuccessController({required this.repository});

  final inAssyncCall = false.obs;
  RxBool contactSaved = false.obs;

  String type = Get.arguments["type"];
  String value = Get.arguments["value"];
  TedInfoModel infoModel =
      Get.arguments["ted_info"] != null ? Get.arguments["ted_info"] : null;
  TransferResponseModel responseTransfer =
      Get.arguments["transfer_response"] != null
          ? Get.arguments["transfer_response"]
          : null;
  // bool contactAlredySaved = Get.arguments['contact_saved'];

  @override
  void onInit() {
    type = Get.arguments["type"];
    value = Get.arguments["value"];
    contactSaved.value = Get.arguments['contact_saved'];
    infoModel =
        Get.arguments["ted_info"] != null ? Get.arguments["ted_info"] : null;
    responseTransfer = Get.arguments["transfer_response"] != null
        ? Get.arguments["transfer_response"]
        : null;
    super.onInit();
  }

  saveContact() async {
    changeAssyncValue();
    var _identifier = infoModel.userName == null
        ? infoModel.cpf?.replaceAll('.', '').replaceAll('-', '')
        : infoModel.userName;
    var response = await repository.saveContact(_identifier!);
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
