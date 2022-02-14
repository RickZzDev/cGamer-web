import 'package:cGamer/app/controllers/score/ranking_controller.dart';
import 'package:cGamer/app/data/provider/score_providers/score_provider.dart';
import 'package:cGamer/app/data/repository/score_repository/score_repository.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:get/get.dart';

class RankingBinding implements Bindings {
  @override
  void dependencies() {
    Requester client = Requester();
    ScoreApiClient _apiClient = ScoreApiClient(httpClient: client);
    Get.lazyPut<RankingController>(
      () => RankingController(
        repository: ScoreRepository(apiClient: _apiClient),
      ),
    );
  }
}
