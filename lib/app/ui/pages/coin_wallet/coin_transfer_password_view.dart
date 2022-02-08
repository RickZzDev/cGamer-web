import 'dart:convert';

import 'package:cGamer/app/controllers/coin_wallet/coin_walelt_controller.dart';
import 'package:cGamer/app/data/models/coin_wallet/transfer_review_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/utils/api_utils/headers.dart';
import 'package:cGamer/app/utils/api_utils/requester.dart';
import 'package:cGamer/app/utils/generic_utils/security_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CoinTransferPasswordView extends StatefulWidget {
  CoinTransferPasswordView({Key? key}) : super(key: key);

  @override
  State<CoinTransferPasswordView> createState() =>
      _CoinTransferPasswordViewState();
}

class _CoinTransferPasswordViewState extends State<CoinTransferPasswordView> {
  late CoinTransferPasswordController _controller;
  late TransferReviewModel model;
  bool isWithdraw = false;
  @override
  void initState() {
    model = Get.arguments['transferReviewModel'];
    isWithdraw = Get.arguments['isWithdraw'];

    _controller = Get.put(
      CoinTransferPasswordController(
        CoinTransferPasswordRepository(
          CoinTransferPasswordProvider(
            Requester(),
          ),
        ),
        model: model,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: _controller.loading.value,
        child: Scaffold(
          backgroundColor: secondaryColor,
          appBar: CustomAppBar(
            appBarTxt: isWithdraw ? 'Retirar \$MAFA' : 'Transferir \$MAFA',
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Obx(
              () => GenericButton(
                text: 'Confirmar',
                txtColor: Colors.white,
                color: primaryColor,
                enabled: _controller.isButtonEnable.value,
                onPressedFunction: () => _controller.sendTransfer(
                    SendTransferRequest(model.userDestination, model.quantity,
                        _controller.passwordController.text, model.taxAmount),
                    isWithdraw),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CustomRichText(
                  normalText: 'Informe a',
                  customText: 'senha da sua conta',
                  normalText2: isWithdraw
                      ? 'para confirmar sua retirada'
                      : 'para confirmar sua transferência',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: 'Senha',
                  obscureText: true,
                  controller: _controller.passwordController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SendTransferRequest {
  final String userName;
  final double quantity;
  final double taxAmount;
  final String password;

  SendTransferRequest(
      this.userName, this.quantity, this.password, this.taxAmount);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['amount'] = quantity;
    map['taxAmount'] = taxAmount;
    map['password'] = SecurityUtils.encodeTo64(password);
    map['username'] = userName;
    return map;
  }

  Map<String, dynamic> toWithdrawJson() {
    Map<String, dynamic> map = {};

    map['amount'] = quantity;
    map['taxAmount'] = taxAmount;
    map['password'] = SecurityUtils.encodeTo64(password);
    map['destinationId'] = userName;
    return map;
  }
}

class CoinTransferPasswordProvider {
  Requester httpClient;
  CoinTransferPasswordProvider(this.httpClient);

  Future sendTransfer(SendTransferRequest request) async {
    try {
      var response = await httpClient.postV2(
          url: 'exchange/transfer-internal',
          body: request.toJson(),
          header: await Headers().getAuthenticatedHeader());

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future sendWithdraw(SendTransferRequest request) async {
    try {
      var response = await httpClient.postV2(
          url: 'exchange/withdraw',
          body: request.toWithdrawJson(),
          header: await Headers().getAuthenticatedHeader());

      return response;
    } catch (e) {
      rethrow;
    }
  }
}

class CoinTransferPasswordRepository {
  CoinTransferPasswordProvider requester;
  CoinTransferPasswordRepository(this.requester);

  Future sendTransfer(SendTransferRequest request) async {
    try {
      await requester.sendTransfer(request);
    } catch (e) {
      rethrow;
    }
  }

  Future sendWithdraw(SendTransferRequest request) async {
    try {
      await requester.sendWithdraw(request);
    } catch (e) {
      rethrow;
    }
  }
}

class CoinTransferPasswordController extends GetxController {
  final CoinTransferPasswordRepository repository;
  final TransferReviewModel model;
  CoinTransferPasswordController(this.repository, {required this.model});

  TextEditingController passwordController = TextEditingController();
  Rx<bool> isButtonEnable = false.obs;
  Rx<bool> loading = false.obs;
  @override
  void onInit() {
    passwordController.addListener(
        () => isButtonEnable.value = passwordController.text.isNotEmpty);
    super.onInit();
  }

  Future<void> sendTransfer(
      SendTransferRequest request, bool isWithdraw) async {
    try {
      loading.value = true;
      if (!isWithdraw) {
        await repository.sendTransfer(request);
      } else {
        await repository.sendWithdraw(request);
      }

      loading.value = false;
      DartNotificationCenter.post(channel: 'refreshMafaWalletPage');
      Get.toNamed(Routes.WALLET_COIN_TRANSFER_SUCCESS,
          arguments: {'transferReviewModel': model, 'isWithdraw': isWithdraw});
    } catch (e) {
      loading.value = false;
      SnackBarUtils.showSnackBar(desc: 'Senha incorreta :(', title: 'Ops..');
    }
  }
}
