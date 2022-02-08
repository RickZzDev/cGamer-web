import 'package:cGamer/app/data/models/score_models/partners_points_model/partners_points_model.dart';
import 'package:cGamer/app/data/repository/score_repository/partners_points_repository/partners_points_repository.dart';
import 'package:cGamer/app/utils/cache_utils/prime_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PartnersPointsController extends GetxController {
  final PartnersPointsRepository repository;
  PartnersPointsController({required this.repository});

  Rx<PartnerPointsModel> statusPartnersResult = PartnerPointsModel().obs;
  Rx<Future?> hasCompletedRequest = Rx<Future?>(null);
  final loading = false.obs;
  var isPrime = false.obs;

  @override
  void onReady() async {
    // indicationCode.value = Get.arguments["indication_code"];
    isPrime.value = await PrimeUtils.isPrime();
    refresh();
    super.onReady();
  }

  Future<void> refresh() async {
    loading.value = true;
    statusPartnersResult.value = await repository.getPartners();
    loading.value = false;
  }
}
