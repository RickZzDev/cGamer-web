import 'package:cGamer/app/controllers/wallet_controllers/card_extract_controllers/card_extract_controller.dart';
import 'package:cGamer/app/data/provider/wallet_providers/card_extract_providers/card_extract_provider.dart';
import 'package:cGamer/app/data/repository/wallet_repositories/card_extract_repositories/card_extract_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class CardExtractBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    CardExtractProvider provider = CardExtractProvider(requester);
    CardExtractRepository repository = CardExtractRepository(provider);

    Get.lazyPut<CardExtractController>(
        () => CardExtractController(repository: repository));
  }
}
