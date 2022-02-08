import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTitleDivider extends StatelessWidget {
  const HomeTitleDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 24, bottom: 12, right: 24),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 0.3,
            ),
          ),
        ),
        padding: EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Últimas movimentações",
              style: textStyle.copyWith(
                  fontWeight: FontWeight.bold, color: primaryColor),
            ),
            /* GestureDetector(
              onTap: () => Get.toNamed(Routes.EXTRACT_PAGE),
              child: Text(
                "Ver todos",
                style: textStyle.copyWith(
                  color: Colors.blue[400],
                  fontSize: 16,
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
