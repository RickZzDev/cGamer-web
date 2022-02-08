import 'package:cGamer/app/utils/api_utils/api_path.dart';

abstract class RecoverPasswordEndpoints {
  static String _url = new API().getUrlComposed();
  static String sendCode(String email) => "/password/$email";
  static String validate(String email, String code) =>
      "/password/$email/validate/$code";
  static String changePassword(String email, String password) =>
      "/password/$email/reset?password=$password";
}
