import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cGamer/app/utils/utils_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionCard extends StatelessWidget {
  final String principalTxt;
  final String? secondTxt;
  final String imgName;
  final bool isApproved;
  final double? customizedSize;
  final Function()? onTap;
  final int length;

  ActionCard(
      {required this.principalTxt,
      this.secondTxt,
      required this.imgName,
      required this.isApproved,
      this.customizedSize,
      required this.length,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isApproved
          ? onTap
          : () => SnackBarUtils.showSnackBar(
                icon: Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
                desc: principalTxt == "Pix"
                    ? 'Estamos finalizando o PIX, e em breve estará disponível para você!'
                    : "Para acessar é necessário ativar sua conta.",
                title: "Atenção",
                color: Colors.orange[400],
              ),
      child: Container(
          width: 90,
          height: 60,
          padding: EdgeInsets.only(left: 16, right: 16),
          margin: firstOrLastVerify(length) == 'first'
              ? EdgeInsets.only(left: 16, right: 4)
              : firstOrLastVerify(length) == 'last'
                  ? EdgeInsets.only(right: 16, left: 4)
                  : EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: Offset(1, 2.0), //(x,y)
                blurRadius: 2.0,
              ),
            ],
            gradient: isApproved
                ? LinearGradient(
                    colors: [Color(0xff925DF0), Color(0xff7662ED)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)
                : LinearGradient(colors: [
                    Color(0xffB7B7B7),
                    Color(0xffB7B7B7),
                  ]),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 30,
                width: 30,
                child: SvgPicture.asset(
                  'assets/images/home_images/$imgName.svg',
                  color: isApproved ? Colors.white : Color(0xff6F7070),
                  height: customizedSize != null ? customizedSize : 30,
                  width: customizedSize != null ? customizedSize : 30,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                principalTxt,
                style: textStyle.copyWith(
                    fontSize: 12,
                    color: isApproved ? Colors.white : Color(0xff6F7070)),
              ),
              principalTxt == "Pix"
                  ? Container(
                      margin: EdgeInsets.only(top: 2),
                      padding: EdgeInsets.fromLTRB(3, 0, 3, 1),
                      decoration: BoxDecoration(
                          color: Color(0xff925DF0),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Text(
                        "Em breve",
                        style: textStyle.copyWith(
                            fontSize: 12, color: Colors.white),
                      ))
                  : Container(),
            ],
          )),
    );
  }

  String? firstOrLastVerify(int length) {
    if (length == 0) {
      return 'first';
    } else if (length == 4) {
      return 'last';
    }
    return null;
  }
}
