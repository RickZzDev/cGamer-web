import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clan_datails_models.dart';
import 'package:cGamer/app/data/models/clans_models/clan_request_entry_model.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_details_repository.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ClanManagerMembersController extends GetxController {
  final ClanDetailsRepository repository;

  ClanManagerMembersController({required this.repository});

  int? clanId;

  var loading = false.obs;

  RxList<ClanDetailsMembers> list = RxList<ClanDetailsMembers>();

  @override
  void onInit() async {
    clanId = Get.arguments['clanId'];
    await getMembers();
    super.onInit();
  }

  Future<bool> getMembers() async {
    loading.value = true;
    try {
      var response = await repository.getClanDetails(clanId.toString());
      list.value = response.members ?? [];
      loading.value = false;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteMember(String customerId) async {
    loading.value = true;
    try {
      var response =
          await repository.removeMember(clanId.toString(), customerId);

      if (ExceptionUtils.verifyIfIsException(response)) {
        loading.value = false;
        SnackBarUtils.showSnackBar(
            desc:
                "Ocorreu um erro ao tentar remover o membro. Tente novamente mais tarde.",
            title: "Atenção");
      } else {
        SnackBarUtils.showSnackBar(
            desc: 'O membro foi removido com sucesso do clã.',
            title: "Atenção",
            color: primaryColor);
        await getMembers();
      }

      loading.value = false;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> promoveMember(String customerId, String role) async {
    loading.value = true;
    try {
      var response =
          await repository.promoveMember(clanId.toString(), customerId, role);

      if (ExceptionUtils.verifyIfIsException(response)) {
        loading.value = false;
        SnackBarUtils.showSnackBar(
            desc:
                "Ocorreu um erro ao tentar promover o membro. Tente novamente mais tarde.",
            title: "Atenção");
      } else {
        SnackBarUtils.showSnackBar(
            desc: 'O membro foi promovido ao Lider do clã.',
            title: "Atenção",
            color: primaryColor);
        await getMembers();
      }

      loading.value = false;
      return true;
    } catch (e) {
      return false;
    }
  }

  void deleteMemberModal(String customerId) {
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
        deleteMember(customerId);
        Navigator.of(Get.context!).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção",
          style: textStyle.copyWith(
              color: secondaryColor, fontWeight: FontWeight.bold)),
      content: Text("Você tem certeza que deseja remover esse membro?",
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

  void promoveModal(String customerId, String role) {
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
        "Transferir Líder",
        style: textStyle.copyWith(color: secondaryColor),
      ),
      onPressed: () {
        promoveMember(customerId, role);
        Navigator.of(Get.context!).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção",
          style: textStyle.copyWith(
              color: secondaryColor, fontWeight: FontWeight.bold)),
      content: Text(
          "Você tem certeza que transferir seu Líder para esse membro?",
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
