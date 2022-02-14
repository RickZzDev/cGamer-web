import 'dart:io';

import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClanDontPermissionAccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
      color: secondaryColor,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          height: 16,
        ),
        Text(
          'Área restrita',
          style: textStyle,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
            'Somente membros do clã podem visualizar essa área, solicite a entrada e aguarde a aprovação.',
            textAlign: TextAlign.center,
            style: textStyle.copyWith(
              fontSize: 16,
            )),
        SizedBox(
          height: 36,
        ),
        SizedBox(
          height: screenHeigthSize * 0.3,
          child: Image.asset(
            "assets/images/cla_images/BGRestrictArea.png",
          ),
        ),
      ]),
    );
  }
}
