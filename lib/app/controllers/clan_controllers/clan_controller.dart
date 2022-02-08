import 'dart:async';

import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_repository.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClanController extends GetxController {
  final ClanRepository repository;

  ClanController({required this.repository});

  ClanPageModel? pageModel;
  RxList<ClanModel> clansLists = RxList<ClanModel>();
  TextEditingController textEditingController = TextEditingController();
  var clanName = ''.obs;
  var showCreateClan = true.obs;
  var isLoading = false.obs;
  Timer? timerToSearch;

  Future<bool> getClansList() async {
    isLoading.value = true;
    try {
      var response = await repository.getClansList(clanName.value);
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: response.message ??
                "Algo de errado aconteceu, tente novamente.",
            title: "Atenção");
        isLoading.value = false;
        return false;
      }
      this.pageModel = response;

      this.clansLists.value = pageModel?.clans ?? [];
      isLoading.value = false;
      return true;
    } catch (e) {
      print(e);
      isLoading.value = false;
      return false;
    }
  }

  void syncClanName(String value) {
    this.clanName.value = value;
  }

  void verify(String text) {
    this.clanName.value = text;

    if (text.isEmpty || text.length < 2) {
      showCreateClan.value = true;

      return;
    }
    showCreateClan.value = false;
  }
}
