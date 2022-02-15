import 'package:auto_size_text/auto_size_text.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MemberItem extends StatelessWidget {
  MemberItem({
    Key? key,
    required this.imageUrl,
    required this.userName,
  }) : super(key: key);

  final String? imageUrl;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 80,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                child: imageUrl == null
                    ? SvgPicture.asset(
                        'assets/images/tab_bar_icons/Perfil.svg',
                        fit: BoxFit.contain,
                        color: primaryColor,
                        height: 24,
                        width: 24,
                      )
                    : Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        height: 35,
                        width: 35,
                      )),
            SizedBox(height: 4),
            AutoSizeText(
              '@' + userName,
              style: textStyle.copyWith(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
