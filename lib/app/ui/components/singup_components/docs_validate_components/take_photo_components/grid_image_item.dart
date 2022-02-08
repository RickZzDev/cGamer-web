import 'package:flutter/material.dart';

class GridImageItem extends StatelessWidget {
  GridImageItem(this.srcImg);
  final String srcImg;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).accentColor)),
      child: Image.asset(
        srcImg,
        fit: BoxFit.cover,
      ),
    );
  }
}
