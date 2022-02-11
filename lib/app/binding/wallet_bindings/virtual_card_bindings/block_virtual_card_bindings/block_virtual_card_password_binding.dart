import 'package:cGamer/app/controllers/wallet_controllers/virtual_card_controllers/block_virtual_card/block_vitual_card_password_step_controller.dart';

import 'package:get/get.dart';

class BlockVirtualCardPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VirtualCardBlockPasswordController>(
      () => VirtualCardBlockPasswordController(),
    );
  }
}
