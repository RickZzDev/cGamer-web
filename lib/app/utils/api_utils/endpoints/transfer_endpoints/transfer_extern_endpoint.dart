import 'package:cGamer/app/utils/api_utils/api_exports.dart';

abstract class TransferExternEdnpoints {
  static String url = "/payments/transfer-external/";

  static String contacts() => url + 'contacts';

  static String getUserInfo(String identifier) => url + identifier;

  static String transfer() => url + 'transfer';

  static String saveContact() => url + 'contacts';

  static String getBanks() => url + 'banks';

  static String getTax() => url + 'tax';
}
