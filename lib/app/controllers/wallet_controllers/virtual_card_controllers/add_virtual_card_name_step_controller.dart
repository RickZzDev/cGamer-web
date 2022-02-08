import 'package:cGamer/app/data/models/wallet_models/virtual_card_request_model.dart';
import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class VirtualCardNameStepController extends GetxController {
  final CardRepository repository;
  VirtualCardNameStepController({required this.repository});

  TextEditingController? nameController;
  var formKey;
  VirtualCardRequestModel model = VirtualCardRequestModel();

  dynamic validateName(String _txt) {
    var validation = Validations().validateName(txt: _txt);
    if (validation != null) {
      return validation;
    }

    if (_txt.length < 3) {
      return "Este nome está muito curto";
    }
    if (_txt.isEmpty) {
      return "Favor preencher o campo com seu nome";
    }

    if (_txt.contains(
        RegExp('[!@#\$*()-+&¬/._,-:;¨=£¢€¥©®•√π÷|?!{-}"×¶∆✓™®0-9]'))) {
      return "Não pode haver caracteres especiais e nem números";
    }

    return null;
  }

  void goNextPage() {
    model.name = nameController?.value.text;
    Get.toNamed(Routes.WALLET_ADD_VIRTUAL_CARD_ALIAS_STEP,
        arguments: {'card_request': model});
  }
}
