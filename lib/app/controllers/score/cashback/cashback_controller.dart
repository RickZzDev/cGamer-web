import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/data/models/score_models/exclusivity_models/cashback_model.dart';
import 'package:cGamer/app/data/repository/score_repository/cashback_repository/cashback_repository.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashbackController extends GetxController {
  final CashbackRepository repository;

  Map<String, dynamic> arguments = Get.arguments;
  var cashbackHasLoaded = false.obs;

  CashBackModel? cashBackModel;

  String? heroTag;
  double points = 0.0;
  HomeController? homeController;

  CashbackController({required this.repository});

  @override
  void onInit() {
    if (arguments['heroTag'] != null) {
      heroTag = arguments['heroTag'];
    }

    if (arguments['points'] != null) {
      this.points = arguments['points'];
    }

    homeController = arguments['homeController'];
    super.onInit();
  }

  @override
  void onReady() async {
    cashbackHasLoaded.value = await getCashback();
    super.onReady();
  }

  Future<bool> getCashback() async {
    try {
      var response = await repository.getCashBackProducts();
      cashBackModel = response;
      return true;
    } catch (e) {
      SnackBarUtils.showSnackBar(
          desc: "Algo de errado aconteceu, recarregue a página.",
          title: "Atenção");
      return false;
    }
  }

  bool hasBalance(double? productValue) {
    if (productValue == null || this.points < productValue) {
      return false;
    }
    return true;
  }

  bool isValidAccount() {
    if (homeController?.statusRegisterResult.value.statusBanlky == "APPROVED") {
      return true;
    }
    return false;
  }
}
