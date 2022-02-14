import 'package:cGamer/app/utils/api_utils/api_exports.dart';

class SelfieEndpoints {
  static String _url = API().getUrlComposed();
  String create() => "/customer/bankly/create";
  String sendDocuments() => "/customer/bankly/documentation";
}
