import 'package:cGamer/app/data/models/wallet_models/virtual_card_request_model.dart';
import 'package:cGamer/app/data/repository/wallet_repositories/card_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class SettingsOptionsController extends GetxController {
  final CardRepository repository;
  SettingsOptionsController({required this.repository});

  VirtualCardModel model = VirtualCardModel();

  @override
  void onInit() {
    model = Get.arguments['card_model'];
    super.onInit();
  }
}
