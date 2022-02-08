import 'dart:convert';

import 'package:cGamer/app/data/data_exports.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/ted_components/ted_accounts_dropdown.dart';

import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';

import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ChooseContactController extends GetxController
    with SingleGetTickerProviderMixin {
  final TransferInterRepository internTransferRepository;
  final TransferExternRepository extertnTransferRepository;

  ChooseContactController(
      {required this.internTransferRepository,
      required this.extertnTransferRepository});

  String? value;
  String? type;
  String? valueWithTax;
  String? tax;
  Rx<ContactsListModel> contacts = ContactsListModel().obs;
  List<AllContacts> contactsFirstValue = <AllContacts>[];
  Future? htppResponse;
  TedInfoModel tedInfoModel = TedInfoModel();

  TextEditingController searchText = TextEditingController();

  final inAssyncCall = false.obs;

  AnimationController? animationController;
  AnimationController? animationController2;
  AnimationController? rotationController;
  Animation<double>? animation;

  FilterUtils _filterUtils = FilterUtils();

  final _showDropDown = false.obs;

  get showDropDown => _showDropDown.value;

  changeAssyncCallValue() => inAssyncCall.value = !inAssyncCall.value;

  filterContacts(String value) {
    _filterUtils.filterContacts(
        value: value,
        listTofilter: contacts,
        initialListValue: contactsFirstValue);
  }

  void setAnimationsControllerValues() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    animationController2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    rotationController = AnimationController(
        duration: const Duration(milliseconds: 250),
        vsync: this,
        value: 0.0,
        lowerBound: 0.0,
        upperBound: 0.5);
    animation =
        CurvedAnimation(parent: rotationController!, curve: Curves.linear);
  }

  @override
  void onInit() {
    setAnimationsControllerValues();
    value = Get.arguments["value"];
    type = Get.arguments['type'];
    valueWithTax = Get.arguments['ammount_with_tax'] ?? null;
    tax = Get.arguments['tax'];
    setAmmountOnObj();
    htppResponse =
        type == "transfer_extern" ? getExternContacts() : getContacts();
    super.onInit();
  }

  void changeIconDirection() {
    if (!showDropDown) {
      animationController?.forward();
      rotationController?.forward();
    } else {
      rotationController?.reverse();
      animationController?.reverse();
    }

    _showDropDown.value = !showDropDown;
  }

  setAmmountOnObj() {
    tedInfoModel.ammount = value;
    tedInfoModel.ammountWithTax = valueWithTax;
    tedInfoModel.transferTax = tax;
  }

  Future getContacts() async {
    try {
      contacts.value = await internTransferRepository.getContacts();
      contactsFirstValue = contacts.value.allContacts ?? [];
    } catch (e) {
      DoNothingAction();
    }
  }

  getExternContacts() async {
    try {
      contacts.value = await extertnTransferRepository.getContacts();
      contactsFirstValue = contacts.value.allContacts ?? [];
    } catch (e) {
      DoNothingAction();
    }
  }

  getUserInfo(String userName) async {
    changeAssyncCallValue();
    var response = await internTransferRepository
        .getUserInfo(SecurityUtils.encodeTo64(userName));
    var exception = ExceptionUtils.verifyIfIsException(response);
    if (exception) {
      SnackBarUtils.showSnackBar(
          desc: response.message,
          title: "Erro",
          color: Colors.orange[400],
          icon: Icon(
            Icons.search_off,
            color: Colors.white,
          ));
      changeAssyncCallValue();
    } else {
      changeAssyncCallValue();
      tedInfoModel = TedInfoModel.fromInternalUserJson(
          json: json.decode(response.body),
          ammountValue: value,
          ammountWithTaxValue: valueWithTax,
          taxValue: tax,
          userNameValue: userName);
      changePage();
    }
  }

  changePage() {
    Get.toNamed(
      Routes.TRANSFER_CONFIRM,
      arguments: {
        "value": value,
        'ted_info': tedInfoModel,
        "contact_saved": true
      },
    );
  }

  Widget defineWidgetContactList(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) if (contacts.value ==
            null ||
        contacts.value.lastContacts == null ||
        contacts.value.lastContacts!.length == 0)
      return Container(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Você ainda não possui nenhum contato",
              style: textStyle.copyWith(fontSize: 14),
            ),
          ],
        ),
      );
    else
      return Container(
        width: double.infinity,
        height: screenHeigthSize * 0.35,
        child: Obx(
          () => ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 12,
            ),
            itemCount: contacts.value.allContacts?.length ?? 0,
            itemBuilder: (context, index) => Container(
              child: type == "transfer_extern"
                  ? Flexible(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => changeIconDirection(),
                            child: ContactSavedExternRow(
                              animation: animation,
                              name:
                                  contacts.value.allContacts?[index].name ?? "",
                              accounts:
                                  contacts.value.allContacts?[index].accounts ??
                                      [],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 28, left: 48),
                            child: Obx(
                              () => GestureDetector(
                                onTap: () => _goToConfirm(
                                    userToSerialize:
                                        contacts.value.allContacts?[index],
                                    indexValue: index),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  height: showDropDown ? 100 : 0,
                                  child: AccountsDropDown(
                                    contacts: contacts,
                                    animationController: animationController!,
                                    showDropDown: showDropDown,
                                    index: index,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ContactRowTransfer(
                      userName:
                          contacts.value.allContacts?[index].customerUserName,
                      onClick: getUserInfo,
                      ammount: value,
                      fullName: contacts.value.allContacts?[index].customerName,
                      letters: GenericUtils.getInitialsName(
                          contacts.value.allContacts?[index].customerName),
                    ),
            ),
          ),
        ),
      );
    else
      return ContactRowTransferShimmer();
  }

  _goToConfirm({required dynamic userToSerialize, int? indexValue}) {
    TedInfoModel _tedFromExternContact = TedInfoModel();
    if (userToSerialize is LastContacts)
      _tedFromExternContact = TedInfoModel().fromExternContact(
        user: userToSerialize,
        ammount: value ?? "0.0",
        ammountWithTax: valueWithTax ?? "0.0",
        tax: tax ?? "0.0",
      );
    else
      _tedFromExternContact = TedInfoModel().fromExternContact(
          user: userToSerialize,
          ammount: value ?? "0.0",
          ammountWithTax: valueWithTax ?? "0.0",
          tax: tax ?? "0.0",
          index: indexValue);
    // print(_tedFromExternContact);
    Get.toNamed(Routes.TRANSFER_TED_CONFIRM,
        arguments: {'ted_info': _tedFromExternContact});
  }

  Widget defineWidgetToDisplay(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.done) if (contacts
                .value.lastContacts ==
            null ||
        contacts.value.lastContacts?.length == 0)
      return Container(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Você ainda não possui nenhum contato recente",
              style: textStyle.copyWith(fontSize: 14),
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
          padding: EdgeInsets.only(right: 24),
          itemBuilder: (context, index) => Align(
            child: type == "transfer_extern"
                ? GestureDetector(
                    onTap: () => _goToConfirm(
                        userToSerialize: contacts.value.lastContacts?[index]),
                    child: ContactExternRow(
                      name: contacts.value.lastContacts?[index].name,
                      letters: GenericUtils.getInitialsName(
                          contacts.value.lastContacts?[index].name),
                      bankName: contacts
                          .value.lastContacts?[index].customerAccount?.bank,
                    ),
                  )
                : ContactComponent(
                    userName:
                        contacts.value.lastContacts?[index].customerUserName,
                    name: contacts.value.lastContacts?[index].customerName,
                    onClick: getUserInfo,
                  ),
          ),
          separatorBuilder: (context, index) => SizedBox(width: 16),
          itemCount: contacts.value.lastContacts?.length ?? 0,
        ),
      );
    else
      return ContactsShimmer();
  }

  Widget defineOptionsWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ChosseContactWay(
            onTap: () => type == "transfer_extern"
                ? Get.toNamed(
                    Routes.TRANSFER_TED_CPF_CNPJ,
                    arguments: {
                      // "value": _controller.value,
                      'ted_info': tedInfoModel
                    },
                  )
                : Get.toNamed(
                    Routes.TRANSFER_CPF,
                    arguments: {
                      "value": value,
                    },
                  ),
            txt: type == "transfer_extern"
                ? " Transferir através do CPF/CNPJ"
                : "Transferir através do CPF de um usuário",
          ),
          type == "transfer_extern"
              ? SizedBox()
              : ChosseContactWay(
                  onTap: () => Get.toNamed(
                    Routes.TRANSFER_AT,
                    arguments: {
                      "value": value,
                    },
                  ),
                  txt: "Transferir através do @ de um usuário",
                ),
        ],
      );
}
