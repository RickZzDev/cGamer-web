import 'package:cGamer/app/data/models/play_together_models/add_game_model.dart';
import 'package:cGamer/app/data/models/play_together_models/play_together_model.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/add_new_game_repositories/add_new_game_repository.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/play_together_repository.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGameController extends GetxController {
  final AddNewGameRepository repository;
  AddGameController({required this.repository});

  TextEditingController searchController = TextEditingController();

  var loading = false.obs;

  var model = AddGameModel().obs;
  var filteredItems = RxList<AddGame>();

  int platformId = -1;


  @override
  void onInit() async {
    platformId = Get.arguments['platformId'];
    await getAllGames();

    super.onInit();
  }

  void filter(String value) {
    List<AddGame>? list = [];

    model.value.games?.forEach((element) {
      if (element.title!.toLowerCase().contains(value.toLowerCase())) {
        list.add(element);
      }
    });

    filteredItems.value = list;

    filteredItems.refresh();
  }

  Future<void> getAllGames() async {
    loading.value = true;
    try {
      var response = await repository.getAllGames(platformId.toString());

      if (ExceptionUtils.verifyIfIsException(response)) {
        loading.value = false;
        SnackBarUtils.showSnackBar(desc: response.message, title: "Atenção");
        return;
      }
      this.model.value = response;
      filteredItems.value = model.value.games ?? [];
      loading.value = false;
      return;
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: "Não foi possível carregar, tente novamente.",
          title: "Atenção");
    }
  }
}
