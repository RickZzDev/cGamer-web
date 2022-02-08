import 'dart:io';

import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class ClanEmblem extends StatelessWidget {
  dynamic urlImage;
  Function()? addNewEmblemAction;

  ClanEmblem({this.urlImage, this.addNewEmblemAction});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      child: Column(
        children: [
          GestureDetector(
            onTap: this.addNewEmblemAction ?? () {},
            child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: this.urlImage.isEmpty || this.urlImage == ''
                    ? Icon(
                        Icons.add,
                        color: Colors.white,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(urlImage))),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Emblema do clã',
            style: textStyle.copyWith(fontSize: 18),
          )
        ],
      ),
    );
  }
}
