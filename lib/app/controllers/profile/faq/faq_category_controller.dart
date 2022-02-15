import 'package:get/get.dart';
import 'package:cGamer/app/data/repository/profile_repositories/faq_repository/faq_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/data/models/profile_model/faq/faq_category_model.dart';
import 'package:cGamer/app/data/models/profile_model/faq/faq_questions_model.dart';
import 'dart:convert';
import 'package:cGamer/app/routes/routes_export.dart';

class FAQCategoryController extends GetxController {
  final FAQRepository repository;

  FAQCategoryController({required this.repository});

  Rx<Future<bool>> hasCompletedCategoriesRequest = Future.value(false).obs;
  Rx<FAQCategoryModel> categoriesResult = FAQCategoryModel().obs;
  Rx<FAQQuestionsModel> questionsResult = FAQQuestionsModel().obs;
  final allComplete = false.obs;
  final loading = false.obs;

  @override
  void onReady() async {
    hasCompletedCategoriesRequest.value = getCategories();
    super.onReady();
  }

  Future<bool> getCategories() async {
    loading.value = true;
    var response = await repository.getCategories();
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      return false;
    } else {
      loading.value = false;
      categoriesResult.value = FAQCategoryModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return true;
    }
  }

  Future<bool> getQuestions(int categoryId) async {
    loading.value = true;
    var response = await repository.getQuestions(categoryId);
    if (ExceptionUtils.verifyIfIsException(response)) {
      loading.value = false;
      return false;
    } else {
      loading.value = false;
      questionsResult.value = FAQQuestionsModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return true;
    }
  }

  void goToQuestions(int categoryId, String categoryTitle) async {
    await getQuestions(categoryId);
    questionsResult.value.categoryTitle = categoryTitle;
    Get.toNamed(Routes.FAQ_QUESTIONS,
        arguments: {'questions_model': questionsResult.value});
  }
}
