import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'package:cGamer/app/controllers/signup/validate_docs/choose_doc_type_controller.dart';

class ChooseDoctypeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseDocTypeController>(() => ChooseDocTypeController());
  }
}
