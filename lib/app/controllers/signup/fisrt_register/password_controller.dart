import 'package:cGamer/app/data/models/profile_model/change_password_model/change_password_model.dart';
import 'package:cGamer/app/data/repository/profile_repositories/change_password_repository/change_password_repository.dart';
import 'package:cGamer/app/utils/api_utils/exception_utils/exception_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:cGamer/app/data/models/retrive_password_models/retrive_password_model.dart';
import 'package:cGamer/app/data/models/user_account_models/user_info.dart';
import 'package:cGamer/app/data/repository/auth_register/register_repository.dart';
import 'package:cGamer/app/data/repository/retrive_password/retrive_password_new_password_repository.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/utils_export.dart';

class PasswordController extends GetxController {
  final RegisterRepository repository;
  final RetrivePasswordNewPasswordRepository retrivePasswordRepository;
  final ChangePasswordRepository changePasswordRepository;

  PasswordController(
      {required this.repository,
      required this.retrivePasswordRepository,
      required this.changePasswordRepository});

  final eightCharacteres = false.obs;
  final lowerCaseLetter = false.obs;
  final upperCaseLetter = false.obs;
  final oneNumber = false.obs;
  final passwordControllerTxt = TextEditingController();

  final registeringUser = false.obs;

  // get registeringUser => this._registeringUser.value;
  // set registeringUser(value) => this._registeringUser.value = value;

  UserRegisterModel _userModel = UserRegisterModel();
  RetrivePasswordModel _retrivePasswordModel = RetrivePasswordModel();
  ChangePasswordModel _changePasswordModel = ChangePasswordModel();

  @override
  void onReady() {
    _userModel = Get.arguments['user_model'];
    _retrivePasswordModel = Get.arguments['retrive_password_model'];
    _changePasswordModel = Get.arguments['change_password_model'];
    super.onReady();
  }

  void setPassword() {
    if (_userModel != null) {
      _userModel.password = passwordControllerTxt.value.text;
    } else if (_retrivePasswordModel != null) {
      _retrivePasswordModel.newPassword = passwordControllerTxt.value.text;
    } else {
      _changePasswordModel.newPassword = passwordControllerTxt.value.text;
    }
  }

  void changePasswordFiled(String value) {
    setPassword();
    value.length >= 8
        ? eightCharacteres.value = true
        : eightCharacteres.value = false;
    value.contains(new RegExp(r'[A-Z]'))
        ? upperCaseLetter.value = true
        : upperCaseLetter.value = false;
    value.contains(new RegExp(r'[a-z]'))
        ? lowerCaseLetter.value = true
        : lowerCaseLetter.value = false;
    value.contains(new RegExp(r'[0-9]'))
        ? oneNumber.value = true
        : oneNumber.value = false;
  }

  bool validateAllCases() {
    if (eightCharacteres.value &&
        lowerCaseLetter.value &&
        upperCaseLetter.value &&
        oneNumber.value)
      return true;
    else
      return false;
  }

  setLoading() => registeringUser.value = !registeringUser.value;

  verifyIfIsException(dynamic responseHttp, BuildContext _context) {
    if (!ExceptionUtils.verifyIfIsException(responseHttp) &&
        responseHttp != null) {
      if (_userModel == null && _retrivePasswordModel != null) {
        changePageToChangePasswordSuccess(true);
      } else if (_changePasswordModel != null) {
        changePageToChangePasswordSuccess(false);
      } else {
        CacheUtils.addToCache(
            key: 'x-token', value: responseHttp.headers['x-token']);
        changePageToSuccess();
      }
    } else {
      setLoading();
      SnackBarUtils.showSnackBar(
          title: "Atenção", desc: responseHttp.message.toString());
    }
  }

  void registerUser(BuildContext _context) async {
    setLoading();
    var _response = await repository.add(_userModel);
    verifyIfIsException(_response, _context);
  }

  void retriveUserPassword(BuildContext _context) async {
    setLoading();
    var _response = await retrivePasswordRepository.changePassword(
        _retrivePasswordModel.email ?? "",
        _retrivePasswordModel.code ?? "",
        _retrivePasswordModel.newPassword ?? "");
    verifyIfIsException(_response, _context);
  }

  void changeUserPassword(BuildContext _context) async {
    setLoading();
    var _response = await changePasswordRepository.changePassword(
        _changePasswordModel.password ?? "",
        _changePasswordModel.newPassword ?? "");
    verifyIfIsException(_response, _context);
  }

  void changePageToSuccess() async {
    Get.offAllNamed(Routes.SUCCESS_ACCOUNT_CREATED,
        arguments: {"username": _userModel.nick});
  }

  void changePageToChangePasswordSuccess(bool isRetrivePasswordFlow) async {
    Get.offAllNamed(Routes.SUCCESS_RETRIVE_PASSWORD,
        arguments: {"retrive_password": isRetrivePasswordFlow});
  }
}
