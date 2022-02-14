import 'package:cGamer/app/controllers/score/gift_card/gift_card_controller.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

class BuyGiftCardPage extends StatelessWidget {
  final _controller = Get.put(GiftCardController());

  BuyGiftCardPage() {
    if (_controller.arguments['heroTag'] != null) {
      this.heroTag = _controller.arguments['heroTag'];
    }
  }

  String? heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          appBarTxt: _controller.model?.title ?? "",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 180,
              child: Center(
                child: Hero(
                  tag: this.heroTag ?? "",
                  child: Image.network(
                    _controller.model?.iconUrl ?? "",
                    fit: BoxFit.cover,
                    width: screenWidthhSize,
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
                        '${_controller.points.formattedPoints()} Rubis',
                        style: textStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Troque seus Rubis por qualquer produto abaixo de sua escolha:',
                    style: textStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GiftCardProductsList(
                      _controller.model?.products, _controller),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Text(
                    _controller.model?.description ?? "",
                    style: textStyle,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
