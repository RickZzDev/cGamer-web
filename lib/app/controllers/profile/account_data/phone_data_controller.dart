import 'dart:convert';

import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/data/repository/profile_repositories/account_data_repository/phone_data_repository.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class PhoneDataController extends GetxController {
  final PhoneDataRepository repository;
  PhoneDataController({required this.repository});

  final phoneController = MaskedTextController(mask: "(00) 00000-0000");
  final phoneWithOutMask = MaskedTextController(mask: "00000000000");

  Rx<PhoneAccount> statusPhoneResult = PhoneAccount().obs;
  Rx<Future<bool>> hasCompletedPhoneRequest = Future.value(false).obs;
  final isPhoneValid = false.obs;
  final loading = false.obs;
  @override
  void onReady() async {
    hasCompletedPhoneRequest.value = getPhone();
    super.onReady();
  }

  Future<bool> getPhone() async {
    loading.value = true;
    var response = await repository.getPhone();
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      return false;
    } else {
      loading.value = false;
      statusPhoneResult.value = PhoneAccount.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      phoneController.value =
          TextEditingValue(text: statusPhoneResult.value.phone ?? "");
      return true;
    }
  }

  Future<bool> updatePhone() async {
    loading.value = true;
    phoneWithOutMask.value = phoneController.value;
    var response = await repository.update(phoneWithOutMask.value.text);
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          title: "Atenção",
          desc: "Não foi possível atualizar seu telefone, tente novamente.");
      return false;
    } else {
      loading.value = false;
      statusPhoneResult.value = PhoneAccount.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      phoneController.value =
          TextEditingValue(text: statusPhoneResult.value.phone ?? "");
      SnackBarUtils.showSnackBar(
          color: primaryColor,
          title: "Sucesso!",
          desc: "Seu telefone foi atualizado.");

      return true;
    }
  }

  bool validatePhoneField() =>
      phoneController.value.text.length == 15 ? true : false;
}
