import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class ValorantSubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Valorant',
              style: textStyle.copyWith(
                  fontWeight: FontWeight.bold, color: primaryColor)),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 50,
            child: Text(
              'Em breve',
              style: textStyle.copyWith(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(border: Border.all(color: primaryColor)),
            child: Center(
              child: Text('Image Here'),
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
