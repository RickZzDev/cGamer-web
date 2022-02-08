import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';

class CashInTedDataShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Banco',
                  style:
                      textStyle.copyWith(fontSize: 14, color: Colors.white54),
                ),
                Shimmer.fromColors(
                  child: Container(
                    height: 20,
                    width: 140,
                    color: Colors.white,
                  ),
                  baseColor: Theme.of(context).accentColor,
                  highlightColor: Colors.blueGrey[400],
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(
                  color: Colors.white54,
                  height: 2,
                ),
                SizedBox(height: 12),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Agência',
                            style: textStyle.copyWith(
                                fontSize: 14, color: Colors.white54),
                          ),
                          Shimmer.fromColors(
                            child: Container(
                              height: 20,
                              width: 140,
                              color: Colors.white,
                            ),
                            baseColor: Theme.of(context).accentColor,
                            highlightColor: Colors.blueGrey[400],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ]),
                Divider(
                  color: Colors.white54,
                  height: 2,
                ),
                SizedBox(height: 12),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Conta',
                            style: textStyle.copyWith(
                                fontSize: 14, color: Colors.white54),
                          ),
                          Shimmer.fromColors(
                            child: Container(
                              height: 20,
                              width: 140,
                              color: Colors.white,
                            ),
                            baseColor: Theme.of(context).accentColor,
                            highlightColor: Colors.blueGrey[400],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ]),
                Divider(
                  color: Colors.white54,
                  height: 2,
                ),
                SizedBox(height: 12),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CPF',
                            style: textStyle.copyWith(
                                fontSize: 14, color: Colors.white54),
                          ),
                          Shimmer.fromColors(
                            child: Container(
                              height: 20,
                              width: 140,
                              color: Colors.white,
                            ),
                            baseColor: Theme.of(context).accentColor,
                            highlightColor: Colors.blueGrey[400],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ]),
                Divider(
                  color: Colors.white54,
                  height: 2,
                ),
              ],
            )));
  }
}
