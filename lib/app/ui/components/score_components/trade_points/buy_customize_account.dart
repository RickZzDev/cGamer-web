import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuyCustomizeAccount extends StatelessWidget {
  BuyCustomizeAccount(
      {required this.title, this.description, this.imagePath, this.onTap});

  final String? title;
  final String? description;
  final String? imagePath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: secondaryColor,
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: Offset(2, 4.0), //(x,y)
                blurRadius: 2.0,
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                imagePath ?? "",
                height: 40,
                width: 40,
                color: primaryColor,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? "",
                    style: textStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    description ?? "",
                    style:
                        textStyle.copyWith(fontSize: 14, color: primaryColor),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_sharp,
                color: primaryColor,
              )
            ],
          ),
        ));
  }
}
