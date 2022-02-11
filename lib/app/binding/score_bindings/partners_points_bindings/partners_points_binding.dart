import 'package:cGamer/app/controllers/score/partners/partners_points_controller.dart';
import 'package:cGamer/app/data/provider/score_providers/partners_points_providers/partners_points_provider.dart';
import 'package:cGamer/app/data/repository/score_repository/partners_points_repository/partners_points_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class PartnersPointsBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    Get.lazyPut<PartnersPointsController>(() => PartnersPointsController(
        repository: PartnersPointsRepository(
            apiClient: PartnerPointsApiClient(httpClient: requester))));
  }
}
