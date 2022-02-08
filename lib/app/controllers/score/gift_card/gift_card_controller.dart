import 'package:cGamer/app/data/models/score_models/gift_cards_models/gift_card_model.dart';
import 'package:get/get.dart';

class GiftCardController extends GetxController {
  GiftCardItemModel? model;
  double points = 0.0;

  Map<String, dynamic> arguments = Get.arguments;

  @override
  void onInit() {
    if (arguments['model'] != null) {
      this.model = arguments['model'];
    }

    if (arguments['points'] != null) {
      points = arguments['points'];
    } else {
      points = 0;
    }

    super.onInit();
  }

  bool hasBalance(double? productValue) {
    if (productValue == null || this.points < productValue) {
      return false;
    }
    return true;
  }
}
