import 'package:cGamer/app/data/models/cash_models/ted_info_model.dart';
import 'package:cGamer/app/data/repository/transfer_repositories/transfer_extern_repo.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

class TedExternIdentifierController extends GetxController {
  final TransferExternRepository repository;
  TedExternIdentifierController({required this.repository});
  Rx<TedInfoModel> tedInfo = TedInfoModel().obs;

  @override
  void onInit() {
    tedInfo.value = Get.arguments["ted_info"];
    super.onInit();
  }

  MaskedTextController textController =
      MaskedTextController(mask: '000.000.000-000');

  MaskedTextController cpfWithOutMsk =
      MaskedTextController(mask: '000000000000');

  MaskedTextController cnpjWithOutMsk =
      MaskedTextController(mask: '00000000000000');

  var formKey = GlobalKey<FormState>();

  inputField(String value) {
    value.length > 15
        ? textController.updateMask('00.000.000/0000-00')
        : textController.updateMask('000.000.000-000');
  }

  mountObj() {
    if (textController.text.length == 14) {
      cpfWithOutMsk.text = textController.text;
      tedInfo.value.cpf = cpfWithOutMsk.text;
      tedInfo.value.cnpj = null;
    } else {
      cnpjWithOutMsk.text = textController.text;
      tedInfo.value.cnpj = cnpjWithOutMsk.text;
      tedInfo.value.cpf = null;
    }
  }

  changePage() {
    mountObj();
    Get.toNamed(Routes.SINGUP_NAME_CPF_STEP,
        arguments: {"origin": "from_ted", "ted_info": tedInfo.value});
  }
}
