import 'package:flutter/cupertino.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart' as themes;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TicketNavCard extends StatelessWidget {
  final String imgName;
  final String label;
  final Function onTap;

  TicketNavCard(
      {required this.imgName, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(8),
        height: 80,
        width: MediaQuery.of(context).size.width * 0.22,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: Offset(1, 2.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
          color: themes.secondaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            width: 1.5,
            color: themes.primaryColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 24,
              child: SvgPicture.asset(
                'assets/images/tab_bar_icons/$imgName.svg',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: themes.textStyle.copyWith(
                fontSize: 12,
                color: themes.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
