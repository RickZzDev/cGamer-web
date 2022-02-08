import 'package:cGamer/app/data/models/cash_models/banks_model.dart';
import 'package:cGamer/app/data/models/cash_models/contacts_intern_list_model.dart';
import 'package:cGamer/app/data/models/profile_model/faq/faq_questions_model.dart';
import 'package:cGamer/app/data/models/profile_model/games_model/games_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FilterUtils {
  filter(
      {required String value,
      required List<dynamic> listTofilter,
      required List initialListValue}) {
    value.length == 0 ? listTofilter = initialListValue : DoNothingAction();

    listTofilter = initialListValue
        .where(
          (element) => element.toLowerCase().contains(value.toLowerCase()),
        )
        .toList();
  }

  filterGames(
      {required String value,
      required List<Games> listTofilter,
      required List<Games> initialListValue}) {
    if (value.length == 0) {
      listTofilter = initialListValue;
      return listTofilter;
    }

    listTofilter = initialListValue
        .where(
          (element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()),
        )
        .toList();

    return listTofilter;
  }

  filterBanks(
      {required String value,
      required Rx<BanksModel> listTofilter,
      required List<Banks> initialListValue}) {
    value.length == 0
        ? listTofilter.value.banks = initialListValue
        : DoNothingAction();

    listTofilter.value.banks = initialListValue
        .where(
          (element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()) ||
              element.bankCode!.toLowerCase().contains(value.toLowerCase()),
        )
        .toList();

    listTofilter.refresh();
  }

  filterQuestions(
      {required String value,
      required RxList<FAQQuestion> listTofilter,
      required List<FAQQuestion> initialListValue}) {
    value.length == 0
        ? listTofilter.assignAll(initialListValue)
        : DoNothingAction();

    listTofilter.assignAll(initialListValue
        .where(
          (element) =>
              element.question!.toLowerCase().contains(value.toLowerCase()) ||
              element.answer!.toLowerCase().contains(value.toLowerCase()),
        )
        .toList());
  }

  filterContacts(
      {required String value,
      required Rx<ContactsListModel> listTofilter,
      required List<AllContacts> initialListValue}) {
    value.length == 0
        ? listTofilter.value.allContacts = initialListValue
        : DoNothingAction();

    listTofilter.value.allContacts = initialListValue
        .where(
          (element) =>
              element.customerName!
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              element.customerUserName!
                  .toLowerCase()
                  .contains(value.toLowerCase()),
        )
        .toList();
    listTofilter.refresh();
  }
}
