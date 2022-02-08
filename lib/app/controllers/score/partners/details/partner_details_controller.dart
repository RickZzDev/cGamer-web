import 'package:cGamer/app/data/models/score_models/partners_points_model/partners_points_model.dart';
import 'package:get/get.dart';

class PartnerDetailsController extends GetxController {
  PartnersPoints? details;

  final Map<String, dynamic> _arguments = Get.arguments;

  @override
  void onInit() {
    details = _arguments['partnerPoints'];
    super.onInit();
  }
}
