import 'dart:convert';

import 'package:cGamer/app/data/models/clans_models/clan_datails_models.dart';
import 'package:cGamer/app/data/models/clans_models/clan_request_entry_model.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_details_repositories/clan_details_repository.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ClanRequestEntryMembersController extends GetxController {
  final ClanDetailsRepository repository;

  ClanRequestEntryMembersController({required this.repository});

  int? clanId;

  var loading = false.obs;

  RxList<ClanRequestMembers> list = RxList<ClanRequestMembers>();

  @override
  void onInit() async {
    clanId = Get.arguments['clanId'];
    await getMembers();
    super.onInit();
  }

  Future<bool> getMembers() async {
    loading.value = true;
    try {
      var response = await repository.getRequestEntry(clanId.toString());
      list.value = ClanRequestEntryModel.fromJson(
            json.decode(utf8.decode(response.bodyBytes)),
          ).members ??
          [];
      loading.value = false;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> approveMember(String customerId) async {
    loading.value = true;
    try {
      var response =
          await repository.approveMember(clanId.toString(), customerId);

      if (ExceptionUtils.verifyIfIsException(response)) {
        loading.value = false;
        SnackBarUtils.showSnackBar(
            desc:
                "Ocorreu um erro ao tentar aprovar o membro. Tente novamente mais tarde.",
            title: "Atenção");
      } else {
        SnackBarUtils.showSnackBar(
            desc: 'A solicitação de entrada deste membro foi aprovada',
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

  Future<bool> reproveMember(String customerId) async {
    loading.value = true;
    try {
      var response =
          await repository.reproveMember(clanId.toString(), customerId);

      if (ExceptionUtils.verifyIfIsException(response)) {
        loading.value = false;
        SnackBarUtils.showSnackBar(
            desc:
                "Ocorreu um erro ao tentar reprovar o membro. Tente novamente mais tarde.",
            title: "Atenção");
      } else {
        SnackBarUtils.showSnackBar(
            desc: 'A solicitação de entrada deste membro foi recusada',
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

  void reproveMemberModal(String customerId) {
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
        reproveMember(customerId);
        Navigator.of(Get.context!).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção",
          style: textStyle.copyWith(
              color: secondaryColor, fontWeight: FontWeight.bold)),
      content: Text("Você tem certeza que deseja recusar esse membro?",
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
