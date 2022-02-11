import 'package:cGamer/app/data/provider/cash_in_provider/cash_in_ted_provider.dart';
import 'package:meta/meta.dart';

class CashInTedRepository {
  final CashInTedApiClient apiClient;

  CashInTedRepository({required this.apiClient});

  getBankAccount() async {
    return await apiClient.getBankAccount();
  }
}
