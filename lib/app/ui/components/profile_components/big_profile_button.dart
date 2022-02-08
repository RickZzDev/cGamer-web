import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class BigProfileButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final String imgSrc;
  final double? size;
  const BigProfileButton(
      {Key? key,
      required this.text,
      required this.imgSrc,
      required this.onTap,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 0.0, color: Colors.transparent),
      ),
      onPressed: () => onTap(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: screenHeigthSize * 0.02,
        ),
        width: screenWidthhSize * 0.9,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidthhSize * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      height: size == null ? 35 : size,
                      width: size == null ? 35 : size,
                      child: SvgPicture.asset(
                        imgSrc,
                        height: 30,
                        width: 30,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: screenWidthhSize * 0.03,
                    ),
                    Text(
                      text,
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
