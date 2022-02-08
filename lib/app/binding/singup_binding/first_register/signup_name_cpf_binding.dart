import 'package:cGamer/app/controllers/signup/fisrt_register/name_cpf_step_controller.dart';
import 'package:get/get.dart';

class NameCpfStepBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NameCpfStepController>(() => NameCpfStepController());
  }
}
