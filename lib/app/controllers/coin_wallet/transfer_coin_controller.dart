import 'package:cGamer/app/controllers/coin_wallet/coin_walelt_controller.dart';
import 'package:cGamer/app/data/models/coin_wallet/transfer_review_model.dart';
import 'package:cGamer/app/data/models/play_together_models/connections_model.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/coin_wallet_repository.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/connections_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/cache_utils/prime_utils.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TransferCoinController extends GetxController {
  final CoinWalletRepository repository;
  final ConnectionsRepository connectionsRepository;
  late String ammountAvailable;

  TransferCoinController(
      {required this.repository, required this.connectionsRepository});

  Rx<GamersListModel> gamersListModel = GamersListModel().obs;
  Rx<bool> loading = false.obs;
  Rx<bool> shouldShowError = false.obs;
  Rx<String> taxValue = RxString("");
  TextEditingController userNameController = TextEditingController();
  MoneyMaskedTextController mafaQuantityController =
      MoneyMaskedTextController();
  MoneyMaskedTextController taxValueController = MoneyMaskedTextController();
  double taxTransfer = 0.005;
  var isPrime = false.obs;

  @override
  void onInit() async {
    isPrime.value = await PrimeUtils.isPrime();
    taxTransfer = isPrime.value ? 0.00 : taxTransfer;
    super.onInit();
  }

  void verifyIfHavaAmmount(
      {required double inputedAmmount, required double availableAmmount}) {
    double taxDouble = (inputedAmmount * taxTransfer).toPrecision(2);
    taxValue.value = taxDouble.toString().replaceAll('.', ',');
    inputedAmmount + (inputedAmmount * taxTransfer) > availableAmmount
        ? shouldShowError.value = true
        : shouldShowError.value = false;
  }

  Future<void> searchUser(String userName) async {
    try {
      loading.value = true;
      gamersListModel.value =
          await connectionsRepository.getGamersList(userName);

      gamersListModel.value.users!
          .removeWhere((element) => element.userName != userName);

      if (gamersListModel.value.users!.length != 1) {
        SnackBarUtils.showSnackBar(
            desc: 'Verifique se o nome de usuário está correto/idêntico :(',
            title: 'Ops...');
        gamersListModel.value.users = [];
      }
      gamersListModel.refresh();

      loading.value = false;
    } catch (e) {
      // SnackBarUtils.showSnackBar(
      //     desc: 'Nenhum usuário encontrado :(', title: 'Ops...');
      loading.value = false;
    }
  }

  Future<void> transferCoin() async {
    Get.toNamed(Routes.WALLET_COIN_TRANSFER_REVIEW, arguments: {
      'transferReviewModel': TransferReviewModel(
          userNameController.text,
          mafaQuantityController.text,
          double.parse(mafaQuantityController.text
              .replaceAll('.', '')
              .replaceAll(',', '.')),
          ammountAvailable,
          double.parse(taxValue.value.replaceAll(',', '.')))
    });
  }

  void resetUserModel() {
    gamersListModel.value = GamersListModel();
  }
}
