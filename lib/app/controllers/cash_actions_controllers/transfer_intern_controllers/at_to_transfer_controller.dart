import 'dart:convert';

import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/data/repository/transfer_repositories/transfer_inter_repo.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class AtToTRansferController extends GetxController {
  final TransferInterRepository repository;

  AtToTRansferController({required this.repository});

  final TextEditingController textController = TextEditingController();
  String? value;

  final inAssyncCall = false.obs;

  TedInfoModel _tedInfoModel = TedInfoModel();

  @override
  void onInit() {
    value = Get.arguments["value"];
    super.onInit();
  }

  changeAssyncValue() => inAssyncCall.value = !inAssyncCall.value;

  searchUser() async {
    changeAssyncValue();
    var response = await repository
        .getUserInfo(SecurityUtils.encodeTo64(textController.text));
    var exception = ExceptionUtils.verifyIfIsException(response);
    if (exception) {
      SnackBarUtils.showSnackBar(
          desc: response.message,
          title: "Falha ao buscar",
          color: Colors.orange[400],
          icon: Icon(
            Icons.search_off,
            color: Colors.white,
          ));
    } else {
      _tedInfoModel = TedInfoModel.fromInternalUserJson(
          json: json.decode(response.body),
          ammountValue: value,
          userNameValue: textController.text);
      changePage();
    }
    changeAssyncValue();
  }

  changePage() {
    Get.toNamed(
      Routes.TRANSFER_CONFIRM,
      arguments: {"value": value, 'ted_info': _tedInfoModel},
    );
  }
}
