import 'package:cGamer/app/utils/generic_utils/filter_utils.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/data/models/profile_model/faq/faq_questions_model.dart';
import 'package:cGamer/app/routes/routes_export.dart';

class FAQQuestionsController extends GetxController {
  Rx<FAQQuestionsModel> faqQuestionsModel = FAQQuestionsModel().obs;
  Rx<Future<bool>> hasCompletedQuestions = Future.value(false).obs;
  final allComplete = false.obs;

  FilterUtils filterUtils = FilterUtils();

  List<FAQQuestion> firstValue = <FAQQuestion>[];

  RxList<FAQQuestion> questions = <FAQQuestion>[].obs;

  filter(String value) {
    filterUtils.filterQuestions(
        value: value, listTofilter: questions, initialListValue: firstValue);
  }

  @override
  void onReady() {
    faqQuestionsModel.value = Get.arguments["questions_model"];
    firstValue = faqQuestionsModel.value.questions ?? [];
    questions.addAll(faqQuestionsModel.value.questions ?? []);
    hasCompletedQuestions.value = Future.value(true);
    super.onReady();
  }

  void goToAnswer(FAQQuestion model, String categoryTitle) async {
    Get.toNamed(Routes.FAQ_ANSWER,
        arguments: {'question_model': model, 'category_title': categoryTitle});
  }
}
