import 'package:cGamer/app/utils/api_utils/api_path.dart';

abstract class BankSlipEndpoints {
  static String url = "${API().getUrlComposed()}/payments/bankslip";
  static String tax = "/tax";
  static String generateTicket(double _value) => "/create?amount=$_value";
  static String ticketList() => "/list";
  static String pdf(String authenticationCode) =>
      "/pdf?authenticationCode=$authenticationCode";
}
