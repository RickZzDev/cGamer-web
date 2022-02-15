import 'package:cGamer/app/controllers/signup/validate_docs/take_photo_tips_controller.dart';
import 'package:get/get.dart';

class TakePhotoTipsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TakePhotoTipsController>(() => TakePhotoTipsController());
  }
}
