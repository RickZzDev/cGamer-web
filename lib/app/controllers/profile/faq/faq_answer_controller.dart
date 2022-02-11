import 'package:get/get.dart';
import 'package:cGamer/app/data/models/profile_model/faq/faq_questions_model.dart';

class FAQAnswerController extends GetxController {
  Rx<FAQQuestion> faqQuestionModel = FAQQuestion().obs;
  var categoryTitle = ''.obs;

  @override
  void onReady() {
    faqQuestionModel.value = Get.arguments["question_model"];
    categoryTitle.value = Get.arguments["category_title"];
    super.onReady();
  }
}
