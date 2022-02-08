import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cGamer/app/controllers/home/home_controller.dart';
import 'package:cGamer/app/utils/generic_utils/styles_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SocialsCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenWidthhSize,
        height: 85,
        margin: EdgeInsets.only(bottom: 24),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          itemBuilder: (context, index) {
            return Container(
                width: 85,
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 0.2),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: GestureDetector(
                    onTap: () async {
                      await getSocialUrl(index);
                    },
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: SizedBox(
                          child: SvgPicture.asset(getAssetIcon(index),
                              width: 36,
                              height: 36,
                              color: Colors.white.withOpacity(0.85)),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8))))));
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 12,
          ),
          itemCount: 5,
        ));
  }

  Future<void> getSocialUrl(int index) async {
    switch (index) {
      case 0:
        if (Platform.isAndroid) {
          launch("https://instagram.com/joggabank");
        } else {
          if (await canLaunch("instagram://user?username=joggabank")) {
            launch("instagram://user?username=joggabank");
          } else {
            launch("https://instagram.com/joggabank");
          }
        }

        break;

      case 1:
        launch("https://discord.gg/QWwnE4JAtw");
        break;

      case 2:
        if (Platform.isAndroid) {
          launch("https://facebook.com/joggabank");
        } else {
          if (await canLaunch("fb://profile?id=joggabank")) {
            launch("fb://profile?id=joggabank");
          } else {
            launch("https://facebook.com/joggabank");
          }
        }

        break;

      case 3:
        if (Platform.isAndroid) {
          launch("https://twitter.com/joggabank");
        } else {
          if (await canLaunch("twitter://user?screen_name=joggabank")) {
            launch("twitter://user?screen_name=joggabank");
          } else {
            launch("https://twitter.com/joggabank");
          }
        }

        break;

      case 4:
        if (Platform.isAndroid) {
          launch("https://linkedin.com/company/joggabank");
        } else {
          if (await canLaunch("linkedin://company/joggabank")) {
            launch("linkedin://company/joggabank");
          } else {
            launch("https://linkedin.com/company/joggabank");
          }
        }

        break;

      default:
        //return "";
        break;
    }
  }

  String getAssetIcon(int index) {
    switch (index) {
      case 0:
        return "assets/images/home_images/instagram.svg";
      case 1:
        return "assets/images/home_images/discord_social.svg";
      case 2:
        return "assets/images/home_images/facebook.svg";
      case 3:
        return "assets/images/home_images/twitter.svg";
      case 4:
        return "assets/images/home_images/linkedin.svg";

      default:
        return "";
    }
  }
}
