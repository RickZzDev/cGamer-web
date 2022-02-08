import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/data/models/user_account_models/user_info.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/utils/validation_utils/validations.dart';

class NameCpfStepController extends GetxController {
  final fromTed = false.obs;
  Rx<TedInfoModel> tedInfo = TedInfoModel().obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    fromTed.value = Get.arguments != null ? true : false;
    tedInfo.value = Get.arguments != null ? Get.arguments["ted_info"] : null;

    super.onInit();
  }

  defineRoute() {
    if (formKey.currentState?.validate() ?? false) {
      mountObj();
      fromTed.value
          ? Get.toNamed(Routes.TRANSFER_TED_CHOOSE_BANK,
              arguments: {"ted_info": tedInfo.value})
          : nextPage();
    }
  }

  mountObj() {
    if (fromTed.value) {
      tedInfo.value.fullName = nameController.text;
    } else {
      _userModel.name = nameController.text;
    }
  }

  Widget defineCustomText() {
    if (fromTed.value) {
      if (tedInfo.value.cpf != null)
        return CustomRichText(
          textAlign: TextAlign.start,
          normalText: 'E qual o',
          customText: "nome completo",
          normalText2: "de quem",
          customText2: "você vai transferir?",
        );
      else
        return CustomRichText(
          textAlign: TextAlign.start,
          normalText: 'E qual a',
          customText: "razão social",
          normalText2: "de quem",
          customText2: "você vai transferir?",
        );
    } else
      return CustomRichText(
        normalText: 'Olá gamer, qual o',
        customText: "seu nome completo?",
        textAlign: TextAlign.start,
      );
  }

  var nameController = TextEditingController();
  var cpfController = MaskedTextController(mask: '000.000.000-00');
  var newCpfMask = MaskedTextController(mask: '00000000000');

  final isNameValid = false.obs;
  final isCpfValid = false.obs;
  final _userModel = UserRegisterModel();

  dynamic removeMask() => newCpfMask.value = cpfController.value;

  dynamic validateName(String _txt) {
    _userModel.name = nameController.value.text;
    var validation = Validations()
        .validateName(txt: _txt, selfName: fromTed.value ? false : true);
    if (validation != null) {
      return validation;
    }

    isNameValid.value = true;
    return null;
  }

  dynamic validateCpf(String _txt) {
    var validationResult = Validations().validateCpf(_txt);
    validationResult == null ? isCpfValid.value = true : DoNothingAction();
    return validationResult;
  }

  void setCpfUnmasked() => _userModel.cpf = newCpfMask.value.text;

  void nextPage() {
    removeMask();
    setCpfUnmasked();
    Get.toNamed(Routes.SINGUP_NAME_PREFERRENCES_STEP, arguments: _userModel);
  }
}
