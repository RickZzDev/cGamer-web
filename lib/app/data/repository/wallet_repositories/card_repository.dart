import 'package:cGamer/app/data/models/wallet_models/virtual_card_request_model.dart';
import 'package:cGamer/app/data/provider/wallet_providers/wallet_provider.dart';
import 'package:meta/meta.dart';

class CardRepository {
  final CardProvider apiClient;

  CardRepository({required this.apiClient});

  activateVirtualCard(VirtualCardRequestModel model) {
    return apiClient.activateVirtualCard(model);
  }

  getVirtualCardDetails() {
    return apiClient.getVirtualCardDetails();
  }

  blockVirtualCard(VirtualCardPasswordsRequestModel model) {
    return apiClient.blockVirtualCard(model);
  }

  unblockVirtualCard(VirtualCardPasswordsRequestModel model) {
    return apiClient.unblockVirtualCard(model);
  }

  deleteVirtualCard(VirtualCardPasswordsRequestModel model) {
    return apiClient.deleteVirtualCard(model);
  }

  getVirtualCardPCI(String password) {
    return apiClient.getVirtualCardPCI(password);
  }

  changePasswordVirtualCard(String accountPassword, String newPassword) {
    return apiClient.changePasswordVirtualCard(accountPassword, newPassword);
  }

  getVirtualCardTransactions(
      {required int size,
      required String finalDate,
      required String startDate}) {
    return apiClient.getVirtualCardTransactions(
        size: size, finalDate: finalDate, startDate: startDate);
  }
}
