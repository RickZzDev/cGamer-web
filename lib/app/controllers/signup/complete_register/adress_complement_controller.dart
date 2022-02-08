import 'package:cGamer/app/data/models/complete_register/complete_register_payload.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AdressComplementController extends GetxController {
  // final MyRepository repository;
  // AdressComplementController({@required this.repository})
  //     : assert(repository != null);
  bool havePreviousData = false;
  final formKeyAdressComplement = GlobalKey<FormState>();
  final adressController = TextEditingController();
  final districtController = TextEditingController();
  final numberController = TextEditingController();
  final complementTxtController = TextEditingController();
  CompleteRegisterPayload? a;

  @override
  onReady() {
    a = Get.arguments["payload"];
    adressController.text = a?.address?.address ?? "";
    districtController.text = a?.address?.district ?? "";
    super.onReady();
  }

  dynamic validateEmpty(String _value) {
    if (_value.isEmpty) {
      return "Campo obrigatório";
    }
    return null;
  }

  changePage() {
    a!.address = Address(
        cep: a?.address?.cep,
        address: adressController.text,
        district: districtController.text,
        number: numberController.text,
        city: a?.address?.city,
        uf: a?.address?.uf,
        complement: complementTxtController.text);

    Get.toNamed(Routes.SINGUP_ADRESS_UF_CITY, arguments: {"payload": a});
  }
}
