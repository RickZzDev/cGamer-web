import 'package:cGamer/app/controllers/wallet_controllers/virtual_card_controllers/block_virtual_card/block_vitual_card_success_controller.dart';
import 'package:get/get.dart';

class BlockVirtualCardSuccessBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VirtualCardBlockSuccessController>(
      () => VirtualCardBlockSuccessController(),
    );
  }
}
