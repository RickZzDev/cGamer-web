import 'package:cGamer/app/ui/components/generic_components/alerts/cupertino_list_alert.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardRowItem extends StatelessWidget {
  const CardRowItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => CupertinoListAlert(),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: PhysicalModel(
          color: Colors.black,
          elevation: 8,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          child: Container(
            width: screenWidthhSize,
            height: 60,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      '',
                      style: textStyle.copyWith(fontSize: 16),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "NuBank",
                          style: textStyle.copyWith(fontSize: 16),
                        ),
                        Text(
                          "Final 023",
                          style: textStyle.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Principal",
                  style: textStyle.copyWith(fontSize: 16, color: primaryColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
