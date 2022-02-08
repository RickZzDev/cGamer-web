import 'package:cGamer/app/controllers/marketplace/marketplace_controller.dart';
import 'package:cGamer/app/routes/app_routes.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialProductsAreaComponent extends StatelessWidget {
  const SpecialProductsAreaComponent(
      {Key? key, required MarketplaceController marketplaceController})
      : _controller = marketplaceController,
        super(key: key);

  final MarketplaceController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 12, 0, 16),
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(24, 0, 24, 8),
                      child: Text(
                        'Lojas parceiras',
                        textAlign: TextAlign.left,
                        style: textStyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    height: 80,
                    width: double.infinity,
                    child: ListView.separated(
                      padding: EdgeInsets.only(left: 24),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Get.toNamed(
                                Routes.MARKETPLACE_STORE_PARTNER_DETAILS,
                                arguments: {
                                  'store_collection': _controller
                                      .storeCollections
                                      .value
                                      .collections?[index]
                                });
                          },
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              offset: Offset(2, 2.0), //(x,y)
                                              blurRadius: 3.0,
                                            ),
                                          ],
                                          border: Border.all(
                                              width: 1.5, color: Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50))),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: CachedNetworkImage(
                                              imageUrl: _controller
                                                      .storeCollections
                                                      .value
                                                      .collections?[index]
                                                      .iconUrl ??
                                                  "",
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              height: 50,
                                              width: 50,
                                              cacheKey: _controller
                                                      .storeCollections
                                                      .value
                                                      .collections?[index]
                                                      .iconUrl ??
                                                  "",
                                              useOldImageOnUrlChange: true,
                                              fit: BoxFit.cover))),
                                ],
                              ),
                              _controller.storeCollections.value
                                          .collections?[index].offMessage !=
                                      null
                                  ? Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        transform: Matrix4.translationValues(
                                            0.0, -8.0, 0.0),
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        width: 55,
                                        height: 16,
                                        child: Center(
                                          child: Text(
                                            _controller
                                                    .storeCollections
                                                    .value
                                                    .collections?[index]
                                                    .offMessage ??
                                                "",
                                            style: textStyle.copyWith(
                                                fontSize: 12,
                                                color: secondaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ))
                                  : Container(),
                            ],
                          )),
                      separatorBuilder: (context, index) => SizedBox(width: 20),
                      itemCount: _controller
                              .storeCollections.value.collections?.length ??
                          0,
                    ),
                  )
                ]))
        // child:
        );
  }
}
