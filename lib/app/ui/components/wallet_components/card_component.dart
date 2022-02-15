import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  final bool isBlocked;
  final String? aliasCard;

  CardComponent({Key? key, required this.isBlocked, this.aliasCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isBlocked
        ? Expanded(
            child: Container(
              width: screenWidthhSize * 0.7,
              height: screenHeigthSize * 0.25,
              // color: Colors.red,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/wallet_images/virtual_card.png',
                    fit: BoxFit.cover,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 16),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.aliasCard ?? "",
                              style: textStyle.copyWith(fontSize: 16),
                              textAlign: TextAlign.end,
                            ),
                          ])),
                ],
              ),
            ),
          )
        : Expanded(
            child: Container(
              width: screenWidthhSize * 0.7,
              height: screenHeigthSize * 0.25,
              // color: Colors.red,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black45),
                    child: Image.asset(
                        'assets/images/wallet_images/virtual_card.png',
                        fit: BoxFit.cover),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 16),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  this.aliasCard ?? "",
                                  style: textStyle.copyWith(
                                      fontSize: 16, color: Colors.grey[700]),
                                  textAlign: TextAlign.end,
                                ),
                              ]))),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Icon(
                        Icons.lock,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
