import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCard extends StatelessWidget {
  const AddCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.WALLET_EXTERN_CARD_FIRST_INFO),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          width: screenWidthhSize,
          height: 60,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(color: secondaryColor),
          ),
          child: Container(
            width: screenWidthhSize,
            height: 60,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: secondaryColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline_outlined,
                  color: secondaryColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Adicionar novo cartão de crédito",
                  style: textStyle.copyWith(
                    fontSize: 16,
                    color: secondaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
