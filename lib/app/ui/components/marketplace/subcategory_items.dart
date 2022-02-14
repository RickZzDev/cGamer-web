import 'package:cGamer/app/data/models/market_place_model/digital_products_model.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/double_extension.dart';

class SubcategoryItem extends StatelessWidget {
  const SubcategoryItem(
      {Key? key,
      required DigitalProduct? product,
      double titleFontSize = 13,
      bool isPrime = false})
      : _product = product,
        _titleFontSize = titleFontSize,
        _isPrime = isPrime,
        super(key: key);

  final DigitalProduct? _product;
  final double _titleFontSize;
  final bool _isPrime;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: screenWidthhSize / 1.8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.white, width: 0.5)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                        imageUrl: _product?.image ?? "",
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        height: 60,
                        width: 80,
                        cacheKey: _product?.image ?? "",
                        useOldImageOnUrlChange: true,
                        fit: BoxFit.cover),
                  )),
            ],
          ),
          SizedBox(
            width: 12,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _product?.name ?? "",
                  maxLines: 2,
                  style: textStyle.copyWith(fontSize: _titleFontSize),
                ),
                Text(
                  _product?.salesPriceFormatted ?? "",
                  style: textStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 4,
                ),
                _product?.points != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                              'Ganhe ',
                              style: textStyle.copyWith(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Image.asset(
                              'assets/images/gamification_icons/cristal.png',
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '${_product?.points.formattedPoints()}',
                              style: textStyle.copyWith(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            _isPrime
                                ? Container(
                                    margin: EdgeInsets.only(left: 4),
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF131313),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    child: Text('X2',
                                        style:
                                            textStyle.copyWith(fontSize: 12)))
                                : Container()
                          ])
                    : Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
