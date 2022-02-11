import 'package:cGamer/app/controllers/bank/bank_controller.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/pages/account_activation/account_activation_page.dart';
import 'package:cGamer/app/ui/pages/pro/pro_view.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProBannerSlim extends StatelessWidget {
  ProBannerSlim({title, image})
      : this._title = title,
        this._image = image;

  final String? _title;
  final String? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 2),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProView(), fullscreenDialog: true),
            );
            // Get.toNamed(Routes.PRO);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            width: screenWidthhSize,
            height: 60,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    //colors: [Color(0xffEA4FF9), Color(0xff5869EB)],
                    colors: [Color(0xff333436), Color(0xff131313)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    _image ?? 'assets/images/gamification_icons/coroa1.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _title ?? 'Conheça o Jogga Prime',
                      style: textStyle.copyWith(fontSize: 14),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
