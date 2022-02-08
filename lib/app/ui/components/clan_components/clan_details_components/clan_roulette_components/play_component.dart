import 'package:auto_size_text/auto_size_text.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class PlayComponent extends StatelessWidget {
  PlayComponent({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        height: screenWidthhSize * 0.20,
        width: screenWidthhSize * 0.20,
        decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 1, color: Colors.tealAccent)),
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AutoSizeText('Jogar',
              style: textStyle.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 6,
          ),
          SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/images/gamification_icons/trophy.png'))
        ])),
      ),
    );
  }
}
