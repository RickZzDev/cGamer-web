import 'package:cGamer/app/data/models/complete_register/complete_register_payload.dart';
import 'package:cGamer/app/data/repository/sign_up_repositories/phone_step_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/cache_utils/cache_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class PhoneStepController extends GetxController {
  final PhoneStepRepository repository;
  PhoneStepController({required this.repository});
  CompleteRegisterPayload payload = CompleteRegisterPayload();
  final sendingCode = false.obs;
  final phoneController = MaskedTextController(mask: "(00) 00000-0000");
  final phoneWithOutMask = MaskedTextController(mask: "00000000000");
  validatePhoneField() =>
      phoneController.value.text.length == 15 ? true : false;

  removePhoneMask() {
    phoneWithOutMask.text = phoneController.text;
    payload.phone = phoneWithOutMask.text;
  }

  Future<DateTime> dateCachePlus3Minutes() async {
    String cacheTime = await CacheUtils.readValue(key: 'date');
    DateTime datetimeParsed = DateTime.parse(cacheTime);
    return datetimeParsed.add(Duration(minutes: 1));
  }

  Future<bool> verifyIfIsAfterCacheTime() async {
    DateTime datePlus3minutes = await dateCachePlus3Minutes();

    if (DateTime.now().isAfter(datePlus3minutes)) {
      CacheUtils.addToCache(key: 'date', value: DateTime.now().toString());
      return true;
    } else
      return false;
  }

  verifySmsSending({Function? funOk, Function? funNotOk}) async {
    if (await verifyIfIsAfterCacheTime()) {
      var response = await repository.sendSmsCode(phoneWithOutMask.text);
      if (response.statusCode == 200) {
        funOk!();
      } else
        SnackBarUtils.showSnackBar(
            title: "Atenção",
            desc:
                "Algo deu errado com o envio do seu token, por favor tente novamente");
    } else {
      funNotOk!();
    }
  }

  saveDateChangePage() async {
    var value = await CacheUtils.readValue(key: 'date');
    if (value == null) {
      await repository.sendSmsCode(payload.phone ?? "");
      await CacheUtils.addToCache(
          key: 'date', value: DateTime.now().toString());
      Get.toNamed(Routes.SINGUP_PHONE_CODE_STEP,
          arguments: {"payload": payload});
      sendingCode.value = false;
    } else {
      verifySmsSending(
        funOk: () async => {
          await CacheUtils.addToCache(
              key: 'date', value: DateTime.now().toString()),
          Get.toNamed(Routes.SINGUP_PHONE_CODE_STEP,
              arguments: {"payload": payload}),
          sendingCode.value = false
        },
        funNotOk: () => {
          SnackBarUtils.showSnackBar(
              title: "Atenção",
              desc: "Precisa aguardar 1 minuto para o envio de um novo token."),
          sendingCode.value = false
        },
      );
    }
  }

  verifyCodeTochangePage() async {
    sendingCode.value = true;
    removePhoneMask();
    saveDateChangePage();
  }
}
