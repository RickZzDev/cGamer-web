import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FrontDocMask extends StatelessWidget {
  const FrontDocMask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      // color: Colors.black.withOpacity(0.8),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: screenHeigthSize * 0.2,
            color: Colors.black.withOpacity(0.8),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.black.withOpacity(0.8),
                  width: 50,
                  // height: 150,
                  // width:,
                ),
                Container(
                  color: Colors.transparent,
                  // width: 50,
                  height: 350,
                ),
                Container(
                  color: Colors.black.withOpacity(0.8),
                  width: 50,
                  // height: 150,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: screenHeigthSize * 0.2,
            color: Colors.black.withOpacity(0.8),
          ),
        ],
      ),
    );
  }
}
