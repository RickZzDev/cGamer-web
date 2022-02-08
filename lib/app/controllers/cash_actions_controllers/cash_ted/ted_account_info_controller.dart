import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class TedAccountInfoController extends GetxController {
  TedInfoModel tedInfo = TedInfoModel();

  @override
  void onInit() {
    tedInfo = Get.arguments["ted_info"];
    super.onInit();
  }

  MaskedTextController agencyController = MaskedTextController(mask: '0000');

  MaskedTextController accountNumberController =
      MaskedTextController(mask: '000000000000');

  changePage() {
    tedInfo.agency = agencyController.text;
    tedInfo.accountNumber = accountNumberController.text;
    Get.toNamed(Routes.TRANSFER_TED_CONFIRM, arguments: {"ted_info": tedInfo});
  }
}
