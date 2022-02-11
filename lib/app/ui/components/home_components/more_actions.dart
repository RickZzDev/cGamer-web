import 'package:cGamer/app/controllers/bank/bank_controller.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/pages/account_activation/account_activation_page.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreActionsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 24, right: 24),
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.MARKETPLACE);
                },
                child: Container(
                  height: 70,
                  width: (screenWidthhSize / 2) - 28,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      SvgPicture.asset(
                        "assets/images/home_images/Gamer_Store.svg",
                        color: primaryColor,
                        height: 36,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Confira nossa',
                            style: textStyle.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Gamer Store',
                            style: textStyle.copyWith(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                )),
            SizedBox(
              width: 8,
            ),
            GestureDetector(
                onTap: () async {
                  final url = 'https://discord.gg/QWwnE4JAtw';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: Container(
                  height: 70,
                  width: (screenWidthhSize / 2) - 28,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    border: Border.all(color: Color(0xFF588AEA)),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      SvgPicture.asset(
                        "assets/images/home_images/discord.svg",
                        color: Color(0xFF588AEA),
                        height: 36,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Acesse nosso',
                            style: textStyle.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Discord',
                            style: textStyle.copyWith(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
