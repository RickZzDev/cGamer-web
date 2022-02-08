abstract class TransferInternEdnpoints {
  static String url = "/payments/transfer-internal/";

  static String contacts() => url + 'contacts';

  static String getUserInfo(String identifier) => url + identifier;

  static String transfer() => url + 'transfer';

  static String saveContact() => url + 'contacts';
}
