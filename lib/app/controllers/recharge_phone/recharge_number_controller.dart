import 'dart:convert';

import 'package:cGamer/app/data/models/cash_models/contacts_intern_list_model.dart';
import 'package:cGamer/app/data/repository/recharge_phone/recharge_phone_contacts_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/shimmers/transfer_shimmers/contact_shimmer.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:cGamer/app/utils/generic_utils/generic_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as utils;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/data/models/recharge_phone/phone_recharge_model.dart';

class RechargeNumberController extends GetxController {
  TextEditingController phoneController =
      MaskedTextController(mask: '(00) 00000-0000');
  TextEditingController phoneWithoutMaskController =
      MaskedTextController(mask: '00000000000');
  TextEditingController nickController = TextEditingController();
  Rx<PhoneContactsListModel> contacts = PhoneContactsListModel().obs;

  Rx<Future<bool>> hasCompletedContactsRequest = Future.value(false).obs;
  PhoneRechargeModel model = PhoneRechargeModel();

  final RechargePhoneContactsRepository repository;
  RechargeNumberController({required this.repository});

  var enabledSaveContact = false.obs;
  var enabledNickContact = false.obs;
  var hasCompletedSaveContact = false.obs;
  var loading = false.obs;

  @override
  void onReady() {
    hasCompletedContactsRequest.value = getContacts();
    super.onReady();
  }

  void changePage() {
    model.phone = phoneController.value.text;
    model.nick = nickController.value.text;
    Get.toNamed(Routes.RECHARGE_PHONE_PROVIDERS,
        arguments: {'phone_recharge_model': model});
  }

  void onChangeNickValue(String txt) {
    if (txt.isNotEmpty) {
      enabledSaveContact.value = true;
    } else {
      enabledSaveContact.value = false;
    }
  }

  void onChangePhone(String txt) {
    if (txt.isNotEmpty && txt.length == 15) {
      enabledNickContact.value = true;
    } else {
      enabledNickContact.value = false;
    }
  }

  void saveContact() async {
    PhoneContact phoneContact = PhoneContact();
    phoneContact.nick = nickController.value.text;
    phoneWithoutMaskController.value = phoneController.value;
    phoneContact.phone = phoneWithoutMaskController.value.text;
    loading.value = true;
    var response = await repository.saveContact(phoneContact);
    if (ExceptionUtils.verifyIfIsException(response)) {
      hasCompletedSaveContact.value = false;
      loading.value = false;
      SnackBarUtils.showSnackBar(
          desc: 'Não foi possível salvar o contato, tente novamente.',
          title: 'Atenção');
    } else {
      loading.value = false;
      hasCompletedContactsRequest.value = getContacts();
      hasCompletedContactsRequest.refresh();
      hasCompletedSaveContact.value = true;
    }
  }

  Future<bool> getContacts() async {
    var response = await repository.getContacts();
    if (ExceptionUtils.verifyIfIsException(response)) {
      return false;
    } else {
      contacts.value = PhoneContactsListModel.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return true;
    }
  }

  Widget defineWidgetToDisplay() {
    if (contacts.value.contacts != null) if (contacts.value.contacts?.length ==
        0)
      return Container(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Você ainda não salvou nenhum contato para recarregar :)",
              style: utils.textStyle.copyWith(fontSize: 14),
            ),
          ],
        ),
      );
    else
      return Container(
        height: 80,
        width: double.infinity,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                model.phone = contacts.value.contacts?[index].phone;
                model.nick = contacts.value.contacts?[index].nick;
                Get.toNamed(Routes.RECHARGE_PHONE_PROVIDERS,
                    arguments: {'phone_recharge_model': model});
              },
              child: Row(children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        GenericUtils.getInitialsName(
                            contacts.value.contacts?[index].nick),
                        style: utils.textStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${contacts.value.contacts?[index].nick}',
                      style: utils.textStyle.copyWith(fontSize: 14),
                    ),
                    Text(
                      '${contacts.value.contacts?[index].phone}',
                      style: utils.textStyle.copyWith(fontSize: 14),
                    ),
                  ],
                )
              ])),
          separatorBuilder: (context, index) => SizedBox(width: 20),
          itemCount: contacts.value.contacts?.length ?? 0,
        ),
      );
    else
      return ContactsShimmer();
  }
}
