import 'package:cGamer/app/controllers/pro/prime_area_controller.dart';
import 'package:cGamer/app/data/provider/pro_provider/pro_provider.dart';
import 'package:cGamer/app/data/repository/pro_repositories/pro_repository.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:get/get.dart';

class PrimeAreaBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();

    ProProvider provider = ProProvider(requester: requester);
    ProRepository repository = ProRepository(provider: provider);

    Get.lazyPut<PrimeAreaController>(
      () => PrimeAreaController(
        repository: repository,
      ),
    );
  }
}
