import 'package:cGamer/app/controllers/score/customization/customization_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

class CustomizationView extends StatelessWidget {
  final CustomizationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(
              appBarTxt: 'Customização',
            )),
        body: Obx(() => ModalProgressHUD(
              inAsyncCall: controller.loading.value,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(24),
                  width: screenWidthhSize,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRichText(
                        normalText: 'Você sabia que pode aparecer em',
                        customText: 'destaque',
                        normalText2: 'para quando outros Gamers',
                        customText2: 'verem',
                        normalText3: 'seu @?',
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Obx(() => controller.hasCompletedColorRequest.value
                          ? PurchaseArea(
                              model: controller.model.value,
                              controller: controller,
                            )
                          : Container(
                              height: 20,
                            )),
                      SizedBox(height: 20),
                      GenericButton(
                          text: 'Comprar',
                          color: primaryColor,
                          onPressedFunction: () =>
                              controller.isValidToContinue(),
                          rightIcon: Row(
                            children: [
                              SizedBox(
                                width: 12,
                              ),
                              Image.asset(
                                'assets/images/gamification_icons/cristal.png',
                                height: 18,
                                width: 18,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                  controller.model.value.priceColor != null
                                      ? controller.model.value.priceColor
                                          .formattedPoints()
                                      : "",
                                  style: textStyle.copyWith(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold))
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            )));
  }
}
