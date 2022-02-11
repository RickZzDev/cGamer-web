import 'dart:async';

import 'package:cGamer/app/data/models/clans_models/clans_models.dart';
import 'package:cGamer/app/data/models/play_together_models/connections_model.dart';
import 'package:cGamer/app/data/repository/clan_repositories/clan_repository.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/connections_repository.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFriendController extends GetxController {
  final ConnectionsRepository repository;

  SearchFriendController({required this.repository});

  GamersListModel? gamersListModel;
  RxList<FriendInvite> gamersList = RxList<FriendInvite>();
  TextEditingController textEditingController = TextEditingController();
  var query = ''.obs;
  var showCreateClan = true.obs;
  var isLoading = false.obs;
  Timer? timerToSearch;

  Future<bool> getGamersList() async {
    isLoading.value = true;
    try {
      var response = await repository.getGamersList(query.value);
      if (ExceptionUtils.verifyIfIsException(response)) {
        SnackBarUtils.showSnackBar(
            desc: response.message ??
                "Algo de errado aconteceu, tente novamente.",
            title: "Atenção");
        isLoading.value = false;
        return false;
      }
      this.gamersListModel = response;

      this.gamersList.value = gamersListModel?.users ?? [];
      isLoading.value = false;
      return true;
    } catch (e) {
      print(e);
      isLoading.value = false;
      return false;
    }
  }

  void syncQuery(String value) {
    this.query.value = value;
  }

  void verify(String text) {
    this.query.value = text;

    if (text.isEmpty || text.length < 3) {
      showCreateClan.value = true;

      return;
    }
    showCreateClan.value = false;
  }
}
