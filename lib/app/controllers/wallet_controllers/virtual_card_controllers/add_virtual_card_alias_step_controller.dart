import 'package:cGamer/app/data/models/wallet_models/virtual_card_request_model.dart';
import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class VirtualCardAliasStepController extends GetxController {
  final CardRepository repository;
  VirtualCardAliasStepController({required this.repository});

  TextEditingController? aliasController;

  var formKey;
  VirtualCardRequestModel? model;

  @override
  void onInit() {
    model = Get.arguments['card_request'];
    super.onInit();
  }

  dynamic validateAlias(String _txt) {
    if (_txt.length < 3 && _txt.length > 0) {
      return "Este apelido está muito curto";
    }
    if (_txt.isEmpty) {
      return "Favor preencher o campo com o apelido do cartão";
    }
    if (_txt.contains(
        RegExp('[!@#\$*()\-+&¬/._,#-?:{-};¨=£¢€¥©®•√π÷|?!"×¶∆✓™®]'))) {
      return "Não pode haver caracteres especiais";
    }

    return null;
  }

  void goNextPage() {
    model?.alias = aliasController?.value.text;
    Get.toNamed(Routes.WALLET_ADD_VIRTUAL_CARD_PASSWORD_STEP,
        arguments: {'card_request': model});
  }
}
