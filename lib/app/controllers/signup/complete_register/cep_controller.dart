import 'package:cGamer/app/data/models/complete_register/complete_register_payload.dart';
import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/data/repository/sign_up_repositories/adress_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class CepController extends GetxController {
  final cepTxtController = MaskedTextController(mask: "00000-000");
  final cepWithOutmask = MaskedTextController(mask: "00000000");
  final formKey = GlobalKey<FormState>();
  var validCep = true.obs;
  var validatingCep = false.obs;
  CepModel? responseCep;
  CompleteRegisterPayload? payload = CompleteRegisterPayload();
  final AdreessRepository repository;
  CepController({required this.repository});

  dynamic getCepInfo(String _cepTxt) async {
    CepModel result = await repository.getCepInfo(cepTxtController.value.text);

    return result;
  }

  dynamic cepValidation(String _value) {
    if (validatingCep.value) {
      return "CEP sendo validado...";
    }
    if (_value.length < 9) {
      return "Digite todos os digitos do ceu CEP";
    }
    if (!validCep.value) {
      return "Digite um CEP válido.";
    }

    if (_value.isEmpty) {
      return "Digitar CEP";
    }

    return null;
  }

  dynamic validateEmpty(String _value) {
    if (_value.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  void onCepTxtChange(String _cepTxt) async {
    if (_cepTxt.length == 9) {
      validatingCep.value = true;
      responseCep = await getCepInfo(_cepTxt);
      if (responseCep!.cep == null) {
        validCep.value = false;
        formKey.currentState?.validate();
        validatingCep.value = false;
      } else {
        validCep.value = true;
        formKey.currentState?.validate();
        validatingCep.value = false;
        changeToComplement();
      }
    }
  }

  changeToComplement() {
    payload = Get.arguments["payload"];
    payload = CompleteRegisterPayload.fromCepPages(
        cepmodel: responseCep!,
        number: "",
        complement: "",
        username: null,
        motherName: payload?.motherName ?? null);
    Get.toNamed(Routes.SINGUP_ADRESS_COMPLEMENT_STEP,
        arguments: {"payload": payload});
  }
}
