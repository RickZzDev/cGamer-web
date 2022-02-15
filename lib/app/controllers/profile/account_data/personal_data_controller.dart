import 'dart:convert';

import 'package:cGamer/app/data/models/models_export.dart';
import 'package:cGamer/app/data/models/user_account_models/user_info.dart';
import 'package:cGamer/app/data/repository/profile_repositories/account_data_repository/personal_data_repository.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PersonalDataController extends GetxController {
  final PersonalDataRepository repository;
  PersonalDataController({required this.repository});

  var nameController = TextEditingController();
  var momNameController = TextEditingController();
  var cpfController = TextEditingController();
  var nickController = TextEditingController();
  var userNameController = TextEditingController();
  var birthDateController = TextEditingController();
  var emailController = TextEditingController();

  Rx<ProfileModel> statusProfileResult = ProfileModel().obs;
  Rx<Future<bool>> hasCompletedProfileRequest = Future.value(false).obs;
  final isNameValid = false.obs;
  final isMomNameValid = false.obs;
  final loading = false.obs;
  final _userModel = UserRegisterModel();

  @override
  void onReady() async {
    hasCompletedProfileRequest.value = getProfile();
    // hasCompletedStatusRequest.value = getStatusRegister();

    super.onReady();
  }

  Future<bool> getProfile() async {
    loading.value = true;
    var response = await repository.getData();
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      return false;
    } else {
      loading.value = false;
      statusProfileResult.value = ProfileModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      momNameController.value = TextEditingValue(
          text: statusProfileResult.value.customerMotherName ?? "");
      nameController.value =
          TextEditingValue(text: statusProfileResult.value.customerName ?? "");
      cpfController.value =
          TextEditingValue(text: statusProfileResult.value.customerCPF ?? "");
      emailController.value =
          TextEditingValue(text: statusProfileResult.value.customerEmail ?? "");
      nickController.value =
          TextEditingValue(text: statusProfileResult.value.customerNick ?? "");
      birthDateController.value = TextEditingValue(
          text: statusProfileResult.value.customerBirthDate ?? "");
      userNameController.value =
          TextEditingValue(text: statusProfileResult.value.userName ?? "");
      return true;
    }
  }

  Future<bool> updateProfile() async {
    loading.value = true;
    ProfileModel model = ProfileModel();
    model.customerNick = nickController.value.text;
    model.customerName = nameController.value.text;
    model.userName = userNameController.value.text;
    model.customerMotherName = momNameController.value.text;

    var response = await repository.update(model);
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      SnackBarUtils.showSnackBar(title: "Atenção", desc: "${response.message}");
      return false;
    } else {
      loading.value = false;
      statusProfileResult.value = ProfileModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      nameController.value =
          TextEditingValue(text: statusProfileResult.value.customerName ?? "");
      cpfController.value =
          TextEditingValue(text: statusProfileResult.value.customerCPF ?? "");
      emailController.value =
          TextEditingValue(text: statusProfileResult.value.customerEmail ?? "");
      nickController.value =
          TextEditingValue(text: statusProfileResult.value.customerNick ?? "");
      birthDateController.value = TextEditingValue(
          text: statusProfileResult.value.customerBirthDate ?? "");
      userNameController.value =
          TextEditingValue(text: statusProfileResult.value.userName ?? "");
      SnackBarUtils.showSnackBar(
          color: primaryColor,
          title: "Sucesso!",
          desc: "Seus dados foram atualizados.");
      return true;
    }
  }

  dynamic validateName(
    String _txt,
  ) {
    _userModel.name = nameController.value.text;
    var validation = Validations().validateName(txt: _txt);
    if (validation != null) {
      return validation;
    }

    if (_txt.isEmpty) {
      isNameValid.value = false;
      return "Favor preencher o campo com seu nome";
    }
    if (_txt.length < 7) {
      isNameValid.value = false;
      return "Por favor, digite seu nome completo :)\nExemplo: João da Silva";
    }

    isNameValid.value = true;
    return null;
  }

  dynamic validateMomName(String _txt) {
    _userModel.motherName = momNameController.value.text;

    var validation = Validations().validateName(txt: _txt, momName: true);

    if (validation != null) {
      return validation;
    }

    if (_txt.isEmpty) {
      isMomNameValid.value = false;
      return "Favor preencher o campo com o nome da sua mãe";
    }
    if (_txt.length < 7) {
      isMomNameValid.value = false;
      return "Por favor, digite o nome da sua mãe completo:)\nExemplo: Maria da Silva";
    }

    isMomNameValid.value = true;
    return null;
  }

  dynamic validateNick(String _txt) {
    if (_txt.length < 3) {
      return "Este nome está muito curto";
    }
    if (_txt.isEmpty) {
      return "Favor preencher o campo com seu nome";
    }

    // isNameValid.value = true;
    return null;
  }

  dynamic validateUsername(String _txt) {
    if (_txt.length < 3) {
      return "Este nome de usuário está muito curto";
    }
    if (_txt.isEmpty) {
      return "Favor preencher o campo com seu nome de usuário";
    }

    // isNameValid.value = true;
    return null;
  }
}
