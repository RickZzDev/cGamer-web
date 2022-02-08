import 'package:cGamer/app/controllers/wallet_controllers/settings_options_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/wallet_components/row_settings_card.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsOptionsPage extends StatelessWidget {
  final SettingsOptionsController _controller =
      Get.find<SettingsOptionsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Configurações",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRichText(
              normalText: "Cartão",
              customText: "virtual",
              normalText2: "final",
              customText2: _controller.model.cardLastFourDigits != null
                  ? "${_controller.model.cardLastFourDigits}"
                  : "",
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.WALLET_SETTINGS_PASSWORD_ACTUAL),
              child: RowSettingsOption(
                txt: "Alterar senha",
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(
                  Routes.WALLET_BLOCK_VIRTUAL_CARD_PASSWORD_STEP,
                  arguments: {'action': 'delete'}),
              child: RowSettingsOption(
                txt: "Excluir cartão",
                onlyBottomBorder: true,
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
