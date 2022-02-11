import 'package:cGamer/app/data/models/clans_models/clan_emblems_model.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EmblemGridItem extends StatelessWidget {
  final EmblemGridItemModel model;
  EmblemGridItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: 95,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          // color: Colors.yellow,

          ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            child: Stack(children: [
              model.isSelected
                  ? Center(
                      child: Container(
                      width: 105,
                      height: 110,
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(220)),
                    ))
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CachedNetworkImage(
                        imageUrl: model.urlImage,
                        fit: BoxFit.contain,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          backgroundColor: primaryColor,
                        ),
                      )),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
