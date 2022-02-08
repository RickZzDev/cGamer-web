import 'package:cGamer/app/controllers/score/cashback/cashback_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/generic_components/rich_text/rich_text.dart';
import 'package:cGamer/app/ui/components/score_components/cashback_components/cashback_products_list.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

class CashbackPage extends StatelessWidget {
  final CashbackController controller = Get.find<CashbackController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          appBarTxt: 'Cashback',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              child: Center(
                child: Hero(
                  tag: this.controller.heroTag ?? "",
                  child: Image.asset(
                    'assets/images/gamification_icons/cashback_icon.png',
                    fit: BoxFit.contain,
                    width: 130,
                    height: 130,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        'Você possui',
                        style: textStyle,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Image.asset(
                        'assets/images/gamification_icons/cristal.png',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        '${controller.points.formattedPoints()} Rubis',
                        style: textStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomRichText(
                      normalText:
                          'Escolha abaixo o valor que deseja receber de ',
                      customText: 'Cashback'),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => controller.cashbackHasLoaded.value
                      ? CashBackProductsList(
                          controller.cashBackModel?.cashback, controller)
                      : CashbackListShimmer())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
