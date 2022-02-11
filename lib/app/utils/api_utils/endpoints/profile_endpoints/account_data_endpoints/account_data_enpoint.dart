import 'package:cGamer/app/utils/api_utils/api_path.dart';

abstract class AccountDataEndpoint {
  static String getAddress = "/customer/address";
  static String getPhone = "/customer/phone";
  static String updateProfile = "/customer/update";
}
