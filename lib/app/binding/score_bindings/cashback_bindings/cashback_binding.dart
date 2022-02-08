import 'package:cGamer/app/controllers/score/cashback/cashback_controller.dart';
import 'package:cGamer/app/data/provider/score_providers/cashback_providers/cashback_provider.dart';
import 'package:cGamer/app/data/repository/score_repository/cashback_repository/cashback_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class CashbackBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = new Requester();
    CashbackProvider provider = CashbackProvider(httpClient: requester);
    CashbackRepository repository = CashbackRepository(provider: provider);
    Get.lazyPut<CashbackController>(
        () => CashbackController(repository: repository));
  }
}
