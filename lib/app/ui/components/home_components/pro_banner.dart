import 'package:cGamer/app/controllers/bank/bank_controller.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/ui/pages/account_activation/account_activation_page.dart';
import 'package:cGamer/app/ui/pages/pro/pro_view.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProBanner extends StatelessWidget {
  ProBanner({title, description, image})
      : this._title = title,
        this._description = description,
        this._image = image;

  final String? _title;
  final String? _description;
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
            height: 100,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    //colors: [Color(0xffEA4FF9), Color(0xff5869EB)],
                    colors: [Color(0xff333436), Color(0xff131313)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _title ?? 'Conheça o Jogga Prime',
                      style: textStyle.copyWith(
                          fontWeight: FontWeight.w700, fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        width: screenWidthhSize - 150,
                        child: Text(
                          _description ??
                              'Acesse e confira todos os benefícios em ser um membro Prime!',
                          maxLines: 2,
                          style: textStyle.copyWith(
                              fontSize: 13, color: Colors.white70),
                        ))
                  ],
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: Image.asset(
                    _image ?? 'assets/images/gamification_icons/coroa1.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
