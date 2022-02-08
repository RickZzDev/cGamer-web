import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/components/components.dart';
import 'package:cGamer/app/ui/components/wallet_components/card_component.dart';
import 'package:cGamer/app/ui/components/wallet_components/card_info_and_actions.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CardInfo extends StatefulWidget {
  @override
  _CardInfoState createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: secondaryColor,
        systemNavigationBarColor: secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: secondaryColor,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(
          appBarTxt: "Dados do cartão",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CardComponent(
                  isBlocked: false,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              CardInfoAndActions(),
              SizedBox(
                height: 16,
              ),
              PhysicalModel(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                elevation: 8,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(color: primaryColor),
                  ),
                  child: MaterialButton(
                    onPressed: () =>
                        Get.toNamed(Routes.WALLET_SETTINGS_OPTIONS),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Configurações",
                          style: textStyle.copyWith(),
                        ),
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: 16,
              ),
              Text("Você ainda não fez transações com esse cartão",
                  style: textStyle.copyWith(fontSize: 16))
            ],
          ),
        ),
      ),
    );
  }
}
