import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class PlayTogetherSwitch extends StatelessWidget {
  final Function(bool) onTap;

  PlayTogetherSwitch({Key? key, required this.onTap, required this.value})
      : super(key: key);

  var value = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: primaryColor, width: 0.5))),
        height: 60,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Obx(() => FlutterSwitch(
                    height: 24,
                    width: 50,
                    activeColor: primaryColor,
                    toggleColor: secondaryColor,
                    value: value.value,
                    onToggle: (v) {
                      value.value = v;
                      onTap(v);
                    },
                  )),
              SizedBox(
                width: 12,
              ),
              Text("Ser encontrado para jogar",
                  style: textStyle.copyWith(fontSize: 16))
            ],
          ),
        ));
  }
}
