import 'package:cGamer/app/data/models/complete_register/complete_register_payload.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import 'package:cGamer/app/data/repository/sign_up_repositories/phone_code_repository.dart';
import 'package:cGamer/app/utils/cache_utils/cache_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';

class PhoneCodeController extends GetxController {
  final PhoneCodeRepository repository;
  PhoneCodeController({required this.repository});
  CompleteRegisterPayload payload = CompleteRegisterPayload();
  final formCodeKey = GlobalKey<FormState>();
  final validatingCode = false.obs;
  final phoneWithMask = MaskedTextController(mask: '(00) 00000-0000');
  final codeController = MaskedTextController(mask: '000-000');
  final codeWithOutMask = MaskedTextController(mask: '000000');

  verifyTimeToSendSmsFromCodeView() async {
    validatingCode.value = true;
    verifySmsSending(
        funOk: () => SnackBarUtils.showSnackBar(
            title: "Sucesso", desc: "Token enviado!", color: Colors.green),
        funNotOk: () => SnackBarUtils.showSnackBar(
            title: "Atenção",
            desc: "Espere por 1 minuto antes de pedir um novo envio"));
  }

  verifySmsSending({Function? funOk, Function? funNotOk}) async {
    if (await verifyIfIsAfterCacheTime()) {
      var response = await repository.sendSmsCode(payload.phone ?? "");
      if (response.statusCode == 200) {
        funOk!();
        validatingCode.value = false;
      } else {
        SnackBarUtils.showSnackBar(
            title: "Atenção",
            desc:
                "Algo deu errado com o envio do seu token, por favor tente novamente");
        validatingCode.value = false;
      }
    } else {
      validatingCode.value = false;
      funNotOk!();
    }
  }

  Future<bool> verifyIfIsAfterCacheTime() async {
    DateTime datePlus3minutes = await dateCachePlus3Minutes();
    print(datePlus3minutes);
    print(DateTime.now());

    if (DateTime.now().isAfter(datePlus3minutes)) {
      CacheUtils.addToCache(key: 'date', value: DateTime.now().toString());
      return true;
    } else
      return false;
  }

  Future<DateTime> dateCachePlus3Minutes() async {
    String cacheTime = await CacheUtils.readValue(key: 'date');
    DateTime datetimeParsed = DateTime.parse(cacheTime);
    return datetimeParsed.add(Duration(minutes: 1));
  }

  validateCodeField() => codeController.value.text.length == 7 ? true : false;

  removeCodeMask() {
    codeWithOutMask.text = codeController.text;
    payload.code = codeWithOutMask.text;
  }

  completeRegister() async {
    validatingCode.value = true;
    removeCodeMask();
    var response = await repository.sendCompleteRegister(payload.toJson());
    if (response is Exception) {
      SnackBarUtils.showSnackBar(
          title: "Atenção",
          desc: "Ocorreu um erro, tente novamente mais tarde.");
      validatingCode.value = false;
    } else
      Get.offAllNamed(Routes.SUCCESS_COMPLETE_REGISTER);
  }
}
