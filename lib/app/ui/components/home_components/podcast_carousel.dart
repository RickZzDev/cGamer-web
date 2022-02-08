import 'package:auto_size_text/auto_size_text.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PodcastCarousel extends StatelessWidget {
  PodcastCarousel({required this.controller});
  final HomeController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenWidthhSize,
        height: 120,
        margin: EdgeInsets.only(bottom: 24),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          itemBuilder: (context, index) {
            return Container(
                width: screenWidthhSize / 1.4,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: GestureDetector(
                  onTap: () async {
                    if (await canLaunch(
                        controller?.podcastsModel.podcasts?[index].url ?? ""))
                      await launch(
                          controller?.podcastsModel.podcasts?[index].url ?? "");
                    else
                      // can't launch url, there is some error
                      throw "Could not launch";
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(left: 4),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    child: SizedBox(
                                        child: CachedNetworkImage(
                                            imageUrl: controller?.podcastsModel
                                                    .podcasts?[index].image ??
                                                "",
                                            fit: BoxFit.cover))),
                              ],
                            )),
                        Container(
                            width: (screenWidthhSize / 1.4) - 108,
                            child: Padding(
                                padding: EdgeInsets.only(top: 8, left: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      SizedBox(
                                          height: 20,
                                          child: Image.asset(
                                              'assets/images/home_images/spotify.png')),
                                      SizedBox(width: 4),
                                      Icon(Icons.open_in_new,
                                          size: 16, color: primaryColor)
                                    ]),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Flexible(
                                        child: Text(
                                            controller?.podcastsModel
                                                    .podcasts?[index].title ??
                                                "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                                fontSize: 14))),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(children: [
                                      Text(
                                          controller?.podcastsModel
                                                  .podcasts?[index].creator ??
                                              "",
                                          style: textStyle.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Text(" - ",
                                          style:
                                              textStyle.copyWith(fontSize: 11)),
                                      Text(
                                          controller?.podcastsModel
                                                  .podcasts?[index].duration ??
                                              "",
                                          style:
                                              textStyle.copyWith(fontSize: 11))
                                    ])
                                  ],
                                )))
                      ]),
                ));
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 12,
          ),
          itemCount: controller?.podcastsModel.podcasts?.length ?? 0,
        ));
  }
}
