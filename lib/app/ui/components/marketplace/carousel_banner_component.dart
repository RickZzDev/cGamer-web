import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselBanner extends StatelessWidget {
  const CarouselBanner(
      {Key? key, required String urlImage, required Function() action})
      : _urlImage = urlImage,
        _action = action,
        super(key: key);

  final String _urlImage;
  final Function() _action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _action,
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width - 48,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: SizedBox(
              child: CachedNetworkImage(
                  imageUrl: _urlImage,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 50,
                  width: 50,
                  cacheKey: _urlImage,
                  useOldImageOnUrlChange: true,
                  fit: BoxFit.fill)),
        ),

        // child:
      ),
    );
  }
}
