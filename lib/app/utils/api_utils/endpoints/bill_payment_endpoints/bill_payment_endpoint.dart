import 'package:cGamer/app/utils/api_utils/api_path.dart';

abstract class BillPaymentEndpoint {
  static String _url = API().getUrlComposed();
  static String confirm = "/payments/bill-payments/confirm";
  static String validate(String code) => "/payments/bill-payments/validate";
}
