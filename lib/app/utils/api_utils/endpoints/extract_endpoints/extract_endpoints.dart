import '../../api_exports.dart';

abstract class ExtractEndpoints {
  static String urlStandardTransactions = "/account/v2/transactions";
  static String urlFilteredTransactions(String startDate, String finalDate) =>
      "/account/v2/transactions?startDate=$startDate&finalDate=$finalDate";
}
