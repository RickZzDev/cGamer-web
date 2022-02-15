import 'package:cGamer/app/data/models/bankslip_models/tax_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/data/repository/bankslip_repositories/bankslip_repository.dart';

class CashInTypeController extends GetxController
    with SingleGetTickerProviderMixin {
  final BankSliptRepository? repository;

  CashInTypeController({required this.repository});

  @override
  void onReady() {
    getTax();
    getTedTax();
    type = Get.arguments["type"];
    super.onReady();
  }

  String? type;

  TaxModel tax = TaxModel();
  TaxModel tedTax = TaxModel();
  AnimationController? animationController;
  AnimationController? animationController2;
  AnimationController? rotationController;
  Animation<double>? animation;

  final _showDropDown = false.obs;

  get showDropDown => _showDropDown.value;

  void setValue(value) => this._showDropDown.value = value;

  void getTax() async => tax = await repository?.getTax();

  void getTedTax() async => tedTax = await repository?.getTedTax();

  void goToChooseValue() => Get.toNamed(Routes.CHOOSE_DEPOSIT_VALUE,
      arguments: {"tax": 0.0, 'type': 'transfer'});

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

  @override
  void onInit() {
    setAnimationsControllerValues();
    super.onInit();
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
}
