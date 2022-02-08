import 'package:cGamer/app/controllers/coin_wallet/success_buy_coin_controller.dart';
import 'package:cGamer/app/data/provider/coin_wallet_provider/coin_wallet_provider.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/coin_wallet_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class SuccessBuyCoinBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    CoinWalletProvider provider = CoinWalletProvider(requester: requester);
    CoinWalletRepository repository = CoinWalletRepository(provider: provider);
    Get.lazyPut<SuccessBuyCoinController>(
        () => SuccessBuyCoinController(repository: repository));
  }
}
