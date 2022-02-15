import 'package:get/get.dart';
import 'package:cGamer/app/controllers/profile/faq/faq_questions_controller.dart';

class FAQQuestionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FAQQuestionsController>(() => FAQQuestionsController());
  }
}
