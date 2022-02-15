import 'package:get/get.dart';

class TermsUseController extends GetxController {
  String? termsUse;
  String? howToRedeem;
  String? title;

  @override
  void onInit() {
    termsUse = Get.arguments['terms_use'];
    howToRedeem = Get.arguments['how_to_redeem'];
    title = Get.arguments['title_terms'];
    super.onInit();
  }
}
