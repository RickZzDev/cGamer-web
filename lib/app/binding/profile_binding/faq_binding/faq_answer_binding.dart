import 'package:get/get.dart';
import 'package:cGamer/app/controllers/profile/faq/faq_answer_controller.dart';

class FAQAnswerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FAQAnswerController>(() => FAQAnswerController());
  }
}
