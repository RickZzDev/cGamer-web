import 'dart:async';

import 'package:get/get.dart';

import 'take_photo_tips_controller.dart';

class PhotoQualityController extends GetxController {
  bool isFrontSide = false;
  @override
  void onInit() {
    String _isFrontSide = Get.arguments['isFrontSide'];
    _isFrontSide == 'isFrontSide' ? isFrontSide = true : isFrontSide = false;
    super.onInit();
  }

  takePictureAgain(TakePhotoTipsController takePhotoTipsController) {
    if (isFrontSide) {
      takePhotoTipsController.file.value = null;
      takePhotoTipsController.pickedImageFrontSide.value = null;
    } else {
      takePhotoTipsController.fileVerso.value = null;
      takePhotoTipsController.pickedImageBackSide.value = null;
    }

    Timer(Duration(milliseconds: 800), () => Get.back());
  }
}
