import 'package:cGamer/app/controllers/coin_wallet/success_buy_coin_controller.dart';
import 'package:cGamer/app/controllers/coin_wallet/transfer_coin_controller.dart';
import 'package:cGamer/app/data/provider/coin_wallet_provider/coin_wallet_provider.dart';
import 'package:cGamer/app/data/provider/play_together_providers/connections_provider.dart';
import 'package:cGamer/app/data/repository/coin_wallet_repositories/coin_wallet_repository.dart';
import 'package:cGamer/app/data/repository/play_together_repositories/connections_repository.dart';
import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:get/get.dart';

class TransferCoinBinding implements Bindings {
  @override
  void dependencies() {
    Requester requester = Requester();
    ConnectionsProvider connectionsProvider = ConnectionsProvider(requester);
    CoinWalletProvider provider = CoinWalletProvider(requester: requester);
    CoinWalletRepository repository = CoinWalletRepository(provider: provider);
    ConnectionsRepository connectionsRepository =
        ConnectionsRepository(connectionsProvider);
    Get.lazyPut<TransferCoinController>(() => TransferCoinController(
        repository: repository, connectionsRepository: connectionsRepository));
  }
}
