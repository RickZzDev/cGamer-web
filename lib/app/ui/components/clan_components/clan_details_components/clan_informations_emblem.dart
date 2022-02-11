import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/material.dart';

class ClanInformationsEmblem extends StatelessWidget {
  final String imageUrl;
  final bool isEditing;
  final VoidCallback onChangeTap;
  ClanInformationsEmblem(this.imageUrl, this.isEditing,
      {required this.onChangeTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      width: 115,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: this.isEditing
            ? Container(
                color: Colors.white.withOpacity(0.5),
                child: Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Center(
                            child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.contain,
                                )))),
                    Container(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    Center(
                      child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: primaryColor,
                          ),
                          onPressed: onChangeTap),
                    )
                  ],
                ),
              )
            : Container(
                margin: EdgeInsets.only(top: 12),
                child: Center(
                    child: SizedBox(
                        height: 110,
                        width: 110,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                        )))),
      ),
    );
  }
}
