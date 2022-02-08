import 'package:cGamer/app/ui/components/home_components/tag_embaixador.dart';
import 'package:cGamer/app/ui/components/home_components/tag_prime.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MatchedPlayer extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String nickName;
  final bool isPrime;
  final bool isEmbaixador;

  MatchedPlayer(
      {Key? key,
      required this.imageUrl,
      required this.userName,
      required this.nickName,
      required this.isPrime,
      required this.isEmbaixador})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          width: 120,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          this.nickName,
          style: textStyle.copyWith(fontSize: 18),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '@' + this.userName,
          style: textStyle.copyWith(fontSize: 16),
        ),
        isEmbaixador
            ? Container(
                margin: EdgeInsets.only(right: 4), child: TagEmbaixador())
            : Container(),
        isPrime
            ? Container(
                margin: EdgeInsets.only(top: 4, bottom: 4),
                child: TagPrime(fontSize: 14.0))
            : Container()
      ],
    );
  }
}
