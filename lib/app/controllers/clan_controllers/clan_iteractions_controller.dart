import 'package:cGamer/app/data/models/clans_models/clan_datails_models.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_details_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ClanIteractionsController extends GetxController {
  final ClanDetailsRepository repository;

  ClanIteractionsController({required this.repository});

  RxList<Iteration> iterations = RxList<Iteration>();
  int? clanId;

  var loading = false.obs;

  @override
  void onInit() {
    iterations.value = Get.arguments['interactions'];
    clanId = Get.arguments['clanId'];
    super.onInit();
  }

  Future<bool> postLeftClan() async {
    loading.value = true;
    try {
      var response = await repository.leftCla(this.clanId.toString());
      loading.value = false;
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(desc: response.message, title: 'Atenção');
        return false;
      }
      Get.offAllNamed(Routes.MAIN_PAGES_HOLDER);
      return true;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, tente novamente mais tarde.",
          title: "Atenção");
      return false;
    }
  }

  void leftClan() {
    Widget cancelButton = TextButton(
      child: Text(
        "Não",
        style: textStyle.copyWith(
            color: secondaryColor, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(Get.context!).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Sim",
        style: textStyle.copyWith(color: secondaryColor),
      ),
      onPressed: () {
        postLeftClan();
        Navigator.of(Get.context!).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção",
          style: textStyle.copyWith(
              color: secondaryColor, fontWeight: FontWeight.bold)),
      content: Text("Você realmente deseja sair do clã?",
          style: textStyle.copyWith(color: secondaryColor)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
