import 'dart:async';
import 'dart:convert';

import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/data/repository/profile_repositories/account_data_repository/address_data_repository.dart';
import 'package:cGamer/app/data/repository/sign_up_repositories/adress_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/keyboard_is_open.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class AddressDataController extends GetxController {
  final AddressDataRepository repository;
  final AdreessRepository cepRepository;

  AddressDataController(
      {required this.repository, required this.cepRepository});

  final cepController = MaskedTextController(mask: "00000-000");
  final cepWithOutmask = MaskedTextController(mask: "00000000");
  var logradouroController = TextEditingController();
  var numberController = TextEditingController();
  var complementController = TextEditingController();
  var districtDateController = TextEditingController();
  var cityController = TextEditingController();
  var ufController = TextEditingController();
  String origin = "profile";
  String? randomNameKey;
  bool isFirstOpen = true;

  var formKey;
  Rx<CepModel> statusAddressResult = CepModel().obs;
  Rx<Future<bool>> hasCompletedAddressRequest = Future.value(false).obs;
  CepModel? responseCep;

  var validCep = false.obs;
  var validatingCep = false.obs;
  final loading = false.obs;

  Map<String, bool> isEnableField = {
    'logradouro': false,
    'bairro': false,
    'cidade': false,
    'uf': false,
  };

  @override
  void onInit() {
    Get.arguments == null
        ? DoNothingAction()
        : origin = Get.arguments["origin"];
    super.onInit();
  }

  @override
  void onReady() async {
    hasCompletedAddressRequest.value = getAddress();

    super.onReady();
  }

  void fillData() async {
    cepController.value = TextEditingValue(text: responseCep?.cep ?? "");
    logradouroController.value =
        TextEditingValue(text: responseCep?.logradouro ?? "");
    districtDateController.value =
        TextEditingValue(text: responseCep?.bairro ?? "");
    ufController.value = TextEditingValue(text: responseCep?.uf ?? "");
    cityController.value =
        TextEditingValue(text: responseCep?.localidade ?? "");
  }

  Future<bool> getAddress() async {
    loading.value = true;
    var response = await repository.getAddress();
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      return false;
    } else {
      loading.value = false;
      statusAddressResult.value = CepModel.fromBEJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      cepController.value =
          TextEditingValue(text: statusAddressResult.value.cep ?? "");
      logradouroController.value =
          TextEditingValue(text: statusAddressResult.value.logradouro ?? "");
      districtDateController.value =
          TextEditingValue(text: statusAddressResult.value.bairro ?? "");
      ufController.value =
          TextEditingValue(text: statusAddressResult.value.uf ?? "");
      cityController.value =
          TextEditingValue(text: statusAddressResult.value.localidade ?? "");
      ufController.value =
          TextEditingValue(text: statusAddressResult.value.complemento ?? "");
      numberController.value =
          TextEditingValue(text: statusAddressResult.value.number ?? "");
      complementController.value =
          TextEditingValue(text: statusAddressResult.value.complemento ?? "");
      onCepTxtChange(statusAddressResult.value.cep ?? "");
      return true;
    }
  }

  Future<bool> updateAddress({BuildContext? context}) async {
    loading.value = true;

    CepModel cepModel = CepModel();
    cepModel.bairro = districtDateController.value.text;
    cepWithOutmask.value = cepController.value;
    cepModel.cep = cepWithOutmask.value.text;
    cepModel.complemento = complementController.value.text;
    cepModel.number = numberController.value.text;
    cepModel.localidade = cityController.value.text;
    cepModel.uf = ufController.value.text;
    cepModel.logradouro = logradouroController.value.text;

    var response = await repository.update(cepModel);
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      SnackBarUtils.showSnackBar(title: "Atenção", desc: response);
      return false;
    } else {
      loading.value = false;
      statusAddressResult.value = CepModel.fromBEJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      cepController.value =
          TextEditingValue(text: statusAddressResult.value.cep ?? "");
      logradouroController.value =
          TextEditingValue(text: statusAddressResult.value.logradouro ?? "");
      districtDateController.value =
          TextEditingValue(text: statusAddressResult.value.bairro ?? "");
      ufController.value =
          TextEditingValue(text: statusAddressResult.value.uf ?? "");
      cityController.value =
          TextEditingValue(text: statusAddressResult.value.localidade ?? "");
      ufController.value =
          TextEditingValue(text: statusAddressResult.value.complemento ?? "");
      numberController.value =
          TextEditingValue(text: statusAddressResult.value.number ?? "");
      complementController.value =
          TextEditingValue(text: statusAddressResult.value.complemento ?? "");
      onCepTxtChange(statusAddressResult.value.cep ?? "", context: context!);

      SnackBarUtils.showSnackBar(
          color: primaryColor,
          title: "Sucesso!",
          desc: "Seu endereço foi atualizado.");

      _verifyToChangePage();

      return true;
    }
  }

  _verifyToChangePage() {
    origin != "profile"
        ? Get.toNamed(Routes.MARKETPLACE_PASSSWORD_CONFIRM)
        : DoNothingAction();
  }

  dynamic getCepInfo(String _cepTxt) async {
    CepModel result = await cepRepository.getCepInfo(cepController.value.text);
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

  emptyVerification(CepModel? cepModel) {
    if (cepModel?.logradouro == "" || (cepModel?.logradouro.isBlank ?? true)) {
      isEnableField['logradouro'] = true;
    } else if (cepModel?.logradouro != "" ||
        !(cepModel?.logradouro.isBlank ?? true)) {
      isEnableField['logradouro'] = false;
    }
    if (cepModel?.bairro == "" || (cepModel?.bairro.isBlank ?? true)) {
      isEnableField['bairro'] = true;
    } else if (cepModel?.bairro != "" || !(cepModel?.bairro.isBlank ?? true)) {
      isEnableField['bairro'] = false;
    }

    if (cepModel?.localidade == "" || (cepModel?.localidade.isBlank ?? true)) {
      isEnableField['cidade'] = true;
    } else if (cepModel?.localidade != "" ||
        !(cepModel?.localidade.isBlank ?? true)) {
      isEnableField['cidade'] = false;
    }

    if (cepModel?.uf == "" || (cepModel?.uf.isBlank ?? true)) {
      isEnableField['uf'] = true;
    } else if (cepModel?.uf != "" || !(cepModel?.uf.isBlank ?? true)) {
      isEnableField['uf'] = false;
    }
  }

  bool statusAddressResultIsNotEmpty() {
    if (!(statusAddressResult.value.bairro.isBlank ?? true) ||
        statusAddressResult.value.bairro != "") {
      if (!(statusAddressResult.value.localidade.isBlank ?? true) ||
          statusAddressResult.value.localidade != "") {
        if (!(statusAddressResult.value.logradouro.isBlank ?? true) ||
            statusAddressResult.value.logradouro != "") {
          if (!(statusAddressResult.value.number.isBlank ?? true) ||
              statusAddressResult.value.number != "") {
            if (!(statusAddressResult.value.uf.isBlank ?? true) ||
                statusAddressResult.value.number != "") {
              return true;
            } else {
              return false;
            }
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void onCepTxtChange(String cepTxt, {BuildContext? context}) async {
    if (cepTxt.length == 9) {
      validatingCep.value = true;

      if (statusAddressResult.value.cep != cepTxt) {
        responseCep = await getCepInfo(cepTxt);
      } else {
        if (statusAddressResultIsNotEmpty()) {
          responseCep = statusAddressResult.value;
        } else {
          responseCep = await getCepInfo(cepTxt);
        }
      }

      emptyVerification(responseCep);
      isFirstOpen
          ? isFirstOpen = false
          : KeyboardIsOpen.verify(context!)
              ? FocusScope.of(context).unfocus()
              : DoNothingAction();

      if (responseCep?.cep == null) {
        validCep.value = false;
        formKey.currentState.validate();
        validatingCep.value = false;
      } else {
        validCep.value = true;
        formKey.currentState.validate();
        validatingCep.value = false;
        fillData();
      }
    }
  }
}
