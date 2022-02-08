import 'package:cGamer/app/utils/api_utils/api_exports.dart';
import 'package:flutter/foundation.dart';

abstract class VirtualCardsEndpoints {
  static String url = "/cards";

  static String activateVirtualCard() => url + '/virtual';
  static String getCardDetails() => '/card-details';
  static String block() => url + '/disabled';
  static String unblock() => url + '/enabled';
  static String delete() => url + '/canceled';

  static String getVirtualCardPCI() => url + '/security-pci';

  static String changePassword() => url + '/password';

  static String getVirtualCardTransactions() => url + '/v2/transactions/';

  static String urlVirtualCardTransactionsWithSize() =>
      getVirtualCardTransactions();

  static String urlFilteredTransactions() => getVirtualCardTransactions();
}
