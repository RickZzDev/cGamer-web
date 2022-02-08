import 'dart:convert';

import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/data/repository/transfer_repositories/transfer_inter_repo.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class CpfToTransferController extends GetxController {
  final TransferInterRepository repository;
  CpfToTransferController({required this.repository});

  final MaskedTextController textController =
      MaskedTextController(mask: '000.000.000-00');

  MaskedTextController cpfWithOutMask =
      MaskedTextController(mask: '00000000000');

  final formKey = GlobalKey<FormState>();

  final inAssyncCall = false.obs;

  String? value;

  TedInfoModel _tedInfoModel = TedInfoModel();

  changePage() {
    Get.toNamed(
      Routes.TRANSFER_CONFIRM,
      arguments: {"value": value, 'ted_info': _tedInfoModel},
    );
  }

  onCpfChange(String _value) async {
    cpfWithOutMask.text = textController.text;
    bool validate = formKey.currentState?.validate() ?? false;
    if (_value.length == 14 && validate) {
      changeAsyncValue();
      String enconded = SecurityUtils.encodeTo64(cpfWithOutMask.text);
      await getUserDetails(enconded);
      changeAsyncValue();
    }
  }

  changeAsyncValue() => inAssyncCall.value = !inAssyncCall.value;

  getUserDetails(String _encoded) async {
    var response = await repository.getUserInfo(_encoded);
    var exception = ExceptionUtils.verifyIfIsException(response);
    if (exception) {
      SnackBarUtils.showSnackBar(
        desc: response.message,
        title: "Atenção",
        color: Colors.orange[400],
        icon: Icon(
          Icons.error,
          color: Colors.white,
        ),
      );
    } else {
      _tedInfoModel = TedInfoModel.fromInternalUserJson(
          json: json.decode(response.body),
          ammountValue: value,
          cpfValue: textController.text);

      // TedInfoModel.fromInternalUserJson(json.decode(response.body));
      print(_tedInfoModel);
      changePage();
    }
  }

  @override
  void onInit() {
    value = Get.arguments["value"];

    super.onInit();
  }
}
