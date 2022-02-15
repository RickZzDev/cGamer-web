import 'package:cGamer/app/utils/generic_utils/snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';

class ExclusiveProductButton extends StatelessWidget {
  ExclusiveProductButton(
      {required this.title, this.imagePath, this.onTap, this.enabled = false});

  final String? title;
  final String? imagePath;
  final Function()? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: enabled
            ? onTap
            : () {
                SnackBarUtils.showSnackBar(
                    desc:
                        "Alcance o nível $title para desbloquear essa loja exclusiva!",
                    title: "Atenção");
              },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: secondaryColor,
            border:
                Border.all(color: enabled ? primaryColor : Colors.grey[500]!),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: Offset(2, 4.0), //(x,y)
                blurRadius: 2.0,
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(alignment: Alignment.center, children: [
                Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF10AF26),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    margin: EdgeInsets.all(6),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                      imageUrl: imagePath ?? "",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: primaryColor,
                          ),
                      height: 90,
                      width: 90,
                      cacheKey: imagePath,
                      useOldImageOnUrlChange: true,
                      fit: BoxFit.cover),
                ),
              ]),
              Text(
                title ?? "",
                style: textStyle.copyWith(
                    fontSize: 16,
                    color: enabled ? Colors.white : Colors.grey[500]),
              ),
            ],
          ),
        ));
  }
}
