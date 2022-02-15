import 'package:auto_size_text/auto_size_text.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BenefitsCard extends StatelessWidget {
  final String txt;
  final String imgName;
  BenefitsCard({
    required this.txt,
    required this.imgName,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 80,
      width: MediaQuery.of(context).size.width * 0.22,
      decoration: BoxDecoration(
        // color: Colors.white70,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(width: 1, color: Colors.white70),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(txt,
              textAlign: TextAlign.center,
              minFontSize: 10,
              maxFontSize: 12,
              style: textStyle.copyWith(color: secondaryColor)),
          Container(
            height: 24,
            child: SvgPicture.asset('assets/images/home_images/$imgName.svg',
                fit: BoxFit.contain, color: secondaryColor),
          ),
        ],
      ),
    );
  }
}
