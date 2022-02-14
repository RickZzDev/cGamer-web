import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class PlatformSelection extends StatelessWidget {
  final Function(dynamic)? onTap;
  PlatformSelection({Key? key, required this.onTap(dynamic)}) : super(key: key);
  var indexTapped = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Selecione a plataforma",
            style: textStyle,
          ),
          Expanded(
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (context, index) => SizedBox(
                        width: 24,
                      ),
                  itemBuilder: (context, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            indexTapped.value = index;
                            onTap!(indexTapped.value);
                          },
                          child: Column(children: [
                            SizedBox(
                              height: 16,
                            ),
                            SvgPicture.asset(getIconWithIndex(index),
                                height: 30,
                                width: 30,
                                fit: BoxFit.contain,
                                color: index == indexTapped.value
                                    ? primaryColor
                                    : Colors.white),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              getTextWithIndex(index),
                              textAlign: TextAlign.center,
                              style: textStyle.copyWith(
                                  fontSize: 13,
                                  color: index == indexTapped.value
                                      ? primaryColor
                                      : Colors.white),
                            )
                          ]),
                        ));
                  }))
        ]),
      ),
    );
  }

  getIconWithIndex(int index) {
    switch (index) {
      case -1:
        return 'assets/images/play_together/all.svg';
      case 0:
        return 'assets/images/play_together/mobile.svg';
      case 1:
        return 'assets/images/play_together/pc.svg';
      case 2:
        return 'assets/images/play_together/playstation.svg';
      case 3:
        return 'assets/images/play_together/xbox.svg';
      case 4:
        return 'assets/images/play_together/nintendo.svg';

      default:
    }
  }

  getTextWithIndex(int index) {
    switch (index) {
      case 0:
        return 'Mobile';
      case 1:
        return 'PC';
      case 2:
        return 'PlayStation';
      case 3:
        return 'Xbox';
      case 4:
        return 'N. Switch';
      default:
    }
  }
}
