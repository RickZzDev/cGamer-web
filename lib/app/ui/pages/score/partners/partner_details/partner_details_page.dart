import 'dart:io';

import 'package:cGamer/app/controllers/score/partners/details/partner_details_controller.dart';
import 'package:cGamer/app/data/models/score_models/partners_points_model/partners_points_model.dart';
import 'package:cGamer/app/ui/components/generic_components/buttons/generic_button.dart';
import 'package:cGamer/app/ui/components/score_components/parters_points/partner_details_components/benefits_list_item.dart';
import 'package:cGamer/app/ui/components/singup_components/custom_appbar.dart';
import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnerDetailsPage extends StatelessWidget {
  final _controller = Get.put(PartnerDetailsController());

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(secondaryColor);
    PartnersPoints? details = _controller.details;

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(
          appBarTxt: details?.additionalInfo?.partner ?? "",
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 180,
                color: Colors.white,
                child: Center(
                  child: Image.network(
                    details?.additionalInfo?.backgroundImageUrl ?? "",
                    width: screenWidthhSize,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/gamification_icons/cristal.png',
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Ganhe ${details?.earnPoints?.toString()} Rubis",
                          style: textStyle.copyWith(
                              color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(details?.additionalInfo?.subTitle ?? "",
                        style: textStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 16,
                    ),
                    Text(details?.additionalInfo?.aboutPartner ?? "",
                        style: textStyle.copyWith(fontSize: 16)),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      height: 110,
                      child: Image.network(details?.iconUrl ?? ""),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      details?.additionalInfo?.benefitsTitle ?? "",
                      style: textStyle.copyWith(
                          fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      //benefits
                      child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          primary: false,
                          itemCount:
                              details?.additionalInfo?.benefits?.length ?? 0,
                          itemBuilder: (context, index) {
                            return BenefitsListItem(
                                details?.additionalInfo?.benefits?[index]);
                          }),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Regras",
                      style: textStyle.copyWith(
                          fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(details?.additionalInfo?.rules ?? "",
                        style: textStyle.copyWith(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: Platform.isIOS ? 90 : 70,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Container(
              margin: EdgeInsets.only(bottom: Platform.isIOS ? 24 : 0),
              child: GenericButton(
                  txtColor: Colors.white,
                  text: details?.additionalInfo?.buttonTitle ?? "Abrir oferta",
                  onPressedFunction: () async {
                    if (await canLaunch(details?.additionalInfo?.url ?? "")) {
                      await launch(details?.additionalInfo?.url ?? "");
                    } else {
                      SnackBarUtils.showSnackBar(
                          desc: "Algo de errado aconteceu.", title: "Atenção");
                    }
                  })),
        ),
      ),
    );
  }
}
