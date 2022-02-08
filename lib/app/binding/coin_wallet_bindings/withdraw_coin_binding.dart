import 'package:cGamer/app/controllers/coin_wallet/buy_coin_controller.dart';
import 'package:cGamer/app/controllers/coin_wallet/withdraw_coin_controller.dart';
import 'package:cGamer/app/controllers/play_to_win/games/lol/lol_account_validation/lol_account_validation_controller.dart';
import 'package:cGamer/app/data/provider/coin_wallet_provider/coin_wallet_provider.dart';
import 'package:cGamer/app/data/provider/play_to_win_providers/lol_providers/lol_provider.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/coin_wallet_repository.dart';
import 'package:cGamer/app/data/repository/play_to_win_repositories/lol_repositories/lol_connection_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class WithdrawCoinBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    CoinWalletProvider provider = CoinWalletProvider(requester: requester);
    CoinWalletRepository repository = CoinWalletRepository(provider: provider);
    Get.lazyPut<WithdrawCoinController>(
        () => WithdrawCoinController(repository: repository));
  }
}
