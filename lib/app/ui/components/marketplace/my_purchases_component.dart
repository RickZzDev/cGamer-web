import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPurchasesMarketplaceComponent extends StatelessWidget {
  // const MyPurchasesMarketplaceComponent(
  //     {
  //        @required MarketplaceController marketplaceController
  //        })
  //     : _controller = marketplaceController,

  // final MarketplaceController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gamer Store',
                          textAlign: TextAlign.start,
                          style: textStyle.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              color: primaryColor,
                              size: 30,
                            )),
                      ])),
              // InkWell(
              //     onTap: () {},
              //     child: Padding(
              //         padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
              //         child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Row(children: [
              //                 Icon(
              //                   Icons.shopping_bag_outlined,
              //                   color: primaryColor,
              //                   size: 36,
              //                 ),
              //                 SizedBox(
              //                   width: 12,
              //                 ),
              //                 Column(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       'Minhas compras',
              //                       style: textStyle.copyWith(
              //                           fontSize: 16,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                     SizedBox(
              //                       height: 2,
              //                     ),
              //                     Text('Acesse o histórico de suas compras',
              //                         style: textStyle.copyWith(fontSize: 14)),
              //                   ],
              //                 )
              //               ]),
              //               Icon(
              //                 Icons.chevron_right,
              //                 color: Colors.white,
              //               )
              //             ]))),
              SizedBox(
                height: 12,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Divider(
                    height: 0.5,
                    color: primaryColor,
                  ))
            ]),
      ),
      // child:
    );
  }
}
